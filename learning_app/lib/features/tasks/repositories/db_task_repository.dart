import 'dart:core';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/keywords/persistence/keywords_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart';
import 'package:learning_app/features/tasks/models/queue_status.dart';
import 'package:learning_app/features/tasks/persistence/task_queue_elements_dao.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/persistence/task_keywords_dao.dart';
import 'package:learning_app/features/tasks/persistence/task_learn_lists_dao.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/features/tasks/persistence/util/task_associations.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';
import 'package:learning_app/features/time_logs/persistence/time_logs_dao.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/database/database.dart' as db;
import 'package:rxdart/rxdart.dart';

/// Concrete repositories implementation using the database with drift
@Injectable(as: TaskRepository)
class DbTaskRepository implements TaskRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final TasksDao _tasksDao = getIt<TasksDao>();
  final LearnListRepository _learnListRepository = getIt<LearnListRepository>();
  final TaskLearnListsDao _taskLearnListsDao = getIt<TaskLearnListsDao>();
  final CategoriesDao _categoriesDao = getIt<CategoriesDao>();
  final KeyWordsDao _keyWordsDao = getIt<KeyWordsDao>();
  final TaskKeywordsDao _taskKeywordsDao = getIt<TaskKeywordsDao>();
  final TimeLogsDao _timeLogsDao = getIt<TimeLogsDao>();
  final TaskQueueElementsDao _queueElementsDao = getIt<TaskQueueElementsDao>();

  Stream<List<TaskWithQueueStatus>>? _orderedFilteredTasksStream;
  Stream<List<TaskWithQueueStatus>>? _queuedTasksStream;

  Stream<TaskAssociations>? _taskAssociationsStream;
  Stream<Map<int?, List<Task>>>? _idToSubTasksStream;

  @override
  Stream<List<TaskWithQueueStatus>> watchFilteredSortedTasks({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    _orderedFilteredTasksStream = _orderedFilteredTasksStream ??
        (_buildFilteredListStream(
          taskFilter: taskFilter,
          taskOrder: taskOrder,
        ));
    return _orderedFilteredTasksStream as Stream<List<TaskWithQueueStatus>>;
  }

  @override
  Stream<List<TaskWithQueueStatus>> watchQueuedTasks() {
    _queuedTasksStream =
        _orderedFilteredTasksStream ?? _buildQueuedTasksStream();
    return _queuedTasksStream as Stream<List<TaskWithQueueStatus>>;
  }

  @override

  /// This creates a stream watching the single task (with subtasks) with the
  /// given ID. Only works with queued tasks, since this are the only ones
  /// required and can be accessed even quicker.
  ///
  /// Do not forget to destroy this stream as soon as it is not required anymore.
  /// Calling this multiple times creates new streams at each call without
  /// destroying the other ones automatically (like with the list streams).
  Stream<TaskWithQueueStatus?> watchQueuedTaskWithId({required int id}) {
    final queuedTasksStream = watchQueuedTasks();
    return queuedTasksStream.map((queuedTasks) {
      final matchingList =
          queuedTasks.where((taskWithStatus) => taskWithStatus.task.id == id);
      return matchingList.isNotEmpty ? matchingList.first : null;
    });
  }

  /// This creates a stream watching the single task (with subtasks) with the
  /// given ID.
  ///
  /// Do not forget to destroy this stream as soon as it is not required anymore.
  /// Calling this multiple times creates new streams at each call without
  /// destroying the other ones automatically (like with the list streams).
  @override
  Stream<TaskWithQueueStatus?> watchTopLevelTaskById({required int id}) {
    final topLevelTaskEntityStream = _tasksDao.watchTaskById(id);
    // Reuse the list-method for combining the entities to a model:
    final singleTopLevelTaskEntityListStream = topLevelTaskEntityStream
        .where((entity) => entity != null)
        .map((entity) => [entity as TaskEntity]);

    final singleModelListStream = _buildListStream(
        topLevelEntitiesStream: singleTopLevelTaskEntityListStream);

    return singleModelListStream
        .where((list) => list.isNotEmpty)
        .map((list) => list.first);
  }

  @override
  Future<int> createTask(CreateTaskDto newTask) async {
    assert(newTask.isReadyToStore);

    // Do the complete update in a transaction, so that the streams will only
    // update once, after the whole update is ready

    // Important: whenever using transactions, every (!) query / update / insert
    //            inside, has to be awaited -> data loss possible otherwise!
    return _tasksDao.transaction(() async {
      int newTaskId = await _tasksDao.createTask(db.TasksCompanion(
        parentTaskId: Value(newTask.parentId),
        title: newTask.title,
        description: newTask.description,
        estimatedTime: newTask.estimatedTime,
        dueDate: newTask.dueDate,
        manualTimeEffortDelta: newTask.manualTimeEffortDelta.present
            ? newTask.manualTimeEffortDelta
            : const Value(Duration.zero),
        categoryId: newTask.categoryId,
        creationDateTime: Value(DateTime.now()),
      ));

      // Create the task-keyword relationships
      if (newTask.keywordIds.present) {
        for (int keyWordId in newTask.keywordIds.value) {
          await _taskKeywordsDao
              .createTaskKeyWordIfNotExists(TaskKeywordsCompanion.insert(
            taskId: newTaskId,
            keywordId: keyWordId,
          ));
        }
      }

      return newTaskId;
    });
  }

  @override
  Future<bool> update(UpdateTaskDto updateDto) async {
    if (!updateDto.containsUpdates()) {
      // No updates requested -> done
      return true;
    }

    // Do the complete update in a transaction, so that the streams will only
    // update once, after the whole update is ready

    // Important: whenever using transactions, every (!) query / update / insert
    //            inside, has to be awaited -> data loss possible otherwise!
    return _tasksDao.transaction(() async {
      int numberTasksChanged = await _tasksDao.updateTask(db.TasksCompanion(
        id: Value(updateDto.id),
        parentTaskId: const Value.absent(),
        // moving tasks is not implemented
        title: updateDto.title,
        description: updateDto.description,
        estimatedTime: updateDto.estimatedTime,
        dueDate: updateDto.dueDate,
        manualTimeEffortDelta: updateDto.manualTimeEffortDelta,
        categoryId: updateDto.categoryId,
        creationDateTime: const Value.absent(),
      ));

      // Update the task-keyword relationship, if changed
      if (updateDto.keywordIds.present) {
        // Delete keyword-relationships that don't apply anymore
        await _taskKeywordsDao.deleteTaskKeyWordsForTaskNotInList(
            updateDto.id, updateDto.keywordIds.value);

        // Insert missing keywords:
        for (int keyWordId in updateDto.keywordIds.value) {
          await _taskKeywordsDao
              .createTaskKeyWordIfNotExists(TaskKeywordsCompanion(
            taskId: Value(updateDto.id),
            keywordId: Value(keyWordId),
          ));
        }
      }

      // Update the task - learn list relationship, if changed
      if (updateDto.learnListsIds.present) {
        // Delete learn list relationships that don't apply anymore
        await _taskLearnListsDao.deleteTaskLearnListsForTaskNotInList(
            updateDto.id, updateDto.learnListsIds.value);

        // Insert missing learn lists:
        for (int listId in updateDto.learnListsIds.value) {
          await _taskLearnListsDao
              .createTaskLearnListIfNotExists(TaskLearnListsCompanion(
            taskId: Value(updateDto.id),
            listId: Value(listId),
          ));
        }
      }

      return numberTasksChanged == 1;
    });
  }

  @override
  Future<bool> deleteById(int id) async {
    final affected = await _tasksDao.deleteTaskById(id);
    return affected > 0;
  }

  @override
  Future<bool> toggleDone(int taskId, bool done) async {
    final affected = await _tasksDao.toggleTaskDoneById(taskId, done);
    return affected > 0;
  }

  Stream<List<TaskWithQueueStatus>> _buildQueuedTasksStream() {
    final topLevelEntitiesStream = _tasksDao.watchQueuedTopLevelTaskEntities();
    return _buildListStream(topLevelEntitiesStream: topLevelEntitiesStream);
  }

  Stream<TaskAssociations> _getAssociationsStream() {
    _taskAssociationsStream =
        _taskAssociationsStream ?? _buildTaskAssociationsStream();
    return _taskAssociationsStream as Stream<TaskAssociations>;
  }

  /// Returns a stream of maps that associate the parent id with its children
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int?, List<Task>>> _getParentIdToSubTasksMapStream() {
    _idToSubTasksStream =
        (_idToSubTasksStream ?? (_createParentIdToSubTasksMapStream()));

    return _idToSubTasksStream as Stream<Map<int?, List<Task>>>;
  }

  /// Creates a stream of all additional associations required to build the
  /// task models.
  ///
  /// To be called only once.
  Stream<TaskAssociations> _buildTaskAssociationsStream() {
    // The streams for other required entities
    final Stream<Map<int, Category>> idToCategoryMapStream =
        _categoriesDao.watchIdToCategoryMap();

    final Stream<Map<int, KeyWord>> keywordIdToKeywordMapStream =
        _keyWordsDao.watchIdToKeywordMap();
    final Stream<List<TaskKeywordEntity>> taskKeywordEntitiesStream =
        _taskKeywordsDao.watchTaskKeyWordEntities();

    final Stream<Map<int, LearnList>> learnListIdToLearnListMapStream =
        _learnListRepository.watchIdToLearnListMap();
    final Stream<List<TaskLearnListEntity>> taskLearnListEntitiesStream =
        _taskLearnListsDao.watchTaskLearnListEntities();

    final Stream<Map<int, List<TimeLog>>> taskIdToTimeLogsMapStream =
        _timeLogsDao.watchTaskIdToTimeLogsMap();

    final Stream<Map<int, QueueStatus>> taskIdToQueueStatusMapStream =
        _queueElementsDao.watchTaskIdToQueueStatusMap();

    // switchMap is used to create a new sub-stream
    // (that uses the most recent values of the top-level stream),
    // whenever the top-level stream emits a new item.
    // The older stream will be automatically destroyed.

    // ->  Start with the streams that will change less often, so that for the
    // more recent changing streams, not everything has to be rebuild

    // Sorry for the nesting! I do not know, if there is another way to
    // implement this functionality, but I think it is still easy enough to
    // be readable :)

    // This will be called whenever the keywords change:
    return keywordIdToKeywordMapStream.switchMap((keywordIdToKeywordMap) {
      // This will be called whenever the task-keyword-relationship changes:
      return taskKeywordEntitiesStream.switchMap((taskKeywords) {
        // Create a map to efficiently allocate the keywords by task-id
        final taskIdToKeywordsMap =
            _createTaskIdToKeywordsMap(taskKeywords, keywordIdToKeywordMap);

        // This will be called whenever the categories change:
        return idToCategoryMapStream.switchMap((idToCategoryMap) {
          // This will be called whenever the learn lists change:
          return learnListIdToLearnListMapStream
              .switchMap((learnListIdToLearnListMap) {
            // This will be called whenever the task-learn-list-relationship changes:
            return taskLearnListEntitiesStream.switchMap((taskLearnLists) {
              // Create a map to efficiently allocate the learn lists by task-id
              final taskIdToLearnListMap = _createTaskIdToLearnListsMap(
                  taskLearnLists, learnListIdToLearnListMap);

              // This will be called whenever the time-logs change:
              return taskIdToTimeLogsMapStream.switchMap((taskIdToTimeLogsMap) {
                // This will be called whenever the task queue changes:
                return taskIdToQueueStatusMapStream
                    .map((taskIdToQueueStatusMap) {
                  return TaskAssociations(
                      idToCategoryMap: idToCategoryMap,
                      taskIdToKeywordsMap: taskIdToKeywordsMap,
                      taskIdToTimeLogsMap: taskIdToTimeLogsMap,
                      taskIdToQueueStatusMap: taskIdToQueueStatusMap,
                      taskIdToLearnListMap: taskIdToLearnListMap);
                });
              });
            });
          });
        });
      });
    });
  }

  /// Actually creates the main filtered task list stream.
  /// To be called only once.
  Stream<List<TaskWithQueueStatus>> _buildFilteredListStream({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    // All top level tasks that match the filters
    // The Keyword-Filter is not applied here, since it depends on a many to many join
    // It will be handled below
    final Stream<List<TaskEntity>> sortedFilteredTopLevelTasksStream =
        _tasksDao.watchFilteredAndSortedTopLevelTaskEntities(
            taskFilter: taskFilter, taskOrder: taskOrder);

    final stream = _buildListStream(
        topLevelEntitiesStream: sortedFilteredTopLevelTasksStream);

    // Apply the keywords-filter, if present
    if (taskFilter.keywords.present) {
      return stream.map(
          (tasksWithQueueStatus) => tasksWithQueueStatus.where((taskWithQueue) {
                final wantedKeywords = taskFilter.keywords.value;
                final actualKeywords = taskWithQueue.task.keywords;
                // accept, if at least one of the wanted is found
                return wantedKeywords.any((wanted) {
                  return actualKeywords.contains(wanted);
                });
              }).toList());
    } else {
      return stream;
    }
  }

  /// Actually creates a task list stream.
  /// Create the list of tasks with their queue status by merging everything
  ///
  /// Since the keywords for the tasks are only known here, the keywords-filter
  /// also is applied here, instead of as part of the tasks-query.
  /// This will only delay this, if the filter is present, though.
  Stream<List<TaskWithQueueStatus>> _buildListStream(
      {required Stream<List<TaskEntity>> topLevelEntitiesStream}) {
    // switchMap is used to create a new sub-stream
    // (that uses the most recent values of the top-level stream),
    // whenever the top-level stream emits a new item.
    // The older stream will be automatically destroyed.

    // This will be called whenever some of the associations change:
    return _getAssociationsStream().switchMap((associations) {
      // This will be called whenever some of the subtasks change:
      return _getParentIdToSubTasksMapStream().switchMap((parentIdToSublevels) {
        // This will be called whenever the tasks change:
        return topLevelEntitiesStream.map((topLevels) {
          // Create the models for top-tier tasks
          final tasksWithQueueStatus = topLevels
              .map((taskEntity) => TaskWithQueueStatus(
                    task: Task(
                      id: taskEntity.id,
                      title: taskEntity.title,
                      doneDateTime: taskEntity.doneDateTime,
                      description: taskEntity.description,
                      category:
                          associations.idToCategoryMap[taskEntity.categoryId],
                      keywords:
                          associations.taskIdToKeywordsMap[taskEntity.id] ?? [],
                      timeLogs:
                          associations.taskIdToTimeLogsMap[taskEntity.id] ?? [],
                      estimatedTime: taskEntity.estimatedTime,
                      dueDate: taskEntity.dueDate,
                      creationDateTime: taskEntity.creationDateTime,
                      children: const [],
                      // children is supposed to be empty here. It will
                      // be added below, since the "idToSubTasks" Map is required that does
                      // not exist right here
                      learnLists:
                          associations.taskIdToLearnListMap[taskEntity.id] ??
                              [],
                      manualTimeEffortDelta: taskEntity.manualTimeEffortDelta,
                    ),
                    queueStatus:
                        associations.taskIdToQueueStatusMap[taskEntity.id],
                  ))
              .toList();

          // Add the sub-tasks (tier 2) to their parents (top tier)
          for (TaskWithQueueStatus taskWithQueue in tasksWithQueueStatus) {
            taskWithQueue.task.children =
                (parentIdToSublevels[taskWithQueue.task.id] ?? []);
          }

          return tasksWithQueueStatus;
        });
      });
    });
  }

  /// Creates a map that allocates all linked keywords for each task-id
  Map<int, List<KeyWord>> _createTaskIdToKeywordsMap(
      List<TaskKeywordEntity> taskKeywords,
      Map<int, KeyWord> keywordIdToKeywordMap) {
    final idToModelList = <int, List<KeyWord>>{};

    for (var taskKeyword in taskKeywords) {
      final nullableKeyword = keywordIdToKeywordMap[taskKeyword.keywordId];
      // If our database is consistent, this will never be null!
      assert(nullableKeyword != null);
      final keyword = nullableKeyword as KeyWord;

      idToModelList.putIfAbsent(taskKeyword.taskId, () => []).add(keyword);
    }
    return idToModelList;
  }

  /// Creates a map that allocates all linked learn lists for each task-id
  Map<int, List<LearnList>> _createTaskIdToLearnListsMap(
      List<TaskLearnListEntity> taskLearnLists,
      Map<int, LearnList> learnListIdToLearnListMap) {
    final idToModelList = <int, List<LearnList>>{};

    for (var taskLearnList in taskLearnLists) {
      final nullableLearnList = learnListIdToLearnListMap[taskLearnList.listId];
      // If our database is consistent, this will never be null!
      assert(nullableLearnList != null);
      final learnList = nullableLearnList as LearnList;

      idToModelList.putIfAbsent(taskLearnList.taskId, () => []).add(learnList);
    }
    return idToModelList;
  }

  /// Creates a stream of maps that associate the parent id with its children
  Stream<Map<int?, List<Task>>> _createParentIdToSubTasksMapStream() {
    final subTasksStream = _tasksDao.watchSubLevelTaskEntities();

    // This will be called whenever some of the associations change:
    return _getAssociationsStream().switchMap((associations) {
      return subTasksStream.map((subLevels) {
        final subTaskModels = [];
        final idToSubTasks = <int?, List<Task>>{};

        // Create the models for subtasks and maps them to their parent-ID
        for (var taskEntity in subLevels) {
          final taskModel = Task(
            id: taskEntity.id,
            title: taskEntity.title,
            doneDateTime: taskEntity.doneDateTime,
            description: taskEntity.description,
            category: associations.idToCategoryMap[taskEntity.categoryId],
            keywords: associations.taskIdToKeywordsMap[taskEntity.id] ?? [],
            timeLogs: associations.taskIdToTimeLogsMap[taskEntity.id] ?? [],
            estimatedTime: taskEntity.estimatedTime,
            dueDate: taskEntity.dueDate,
            creationDateTime: taskEntity.creationDateTime,
            children: const [],
            // children is supposed to be empty here. It will
            // be added below, since the "idToSubTasks" Map is required that does
            // not exist right here
            learnLists: associations.taskIdToLearnListMap[taskEntity.id] ?? [],
            manualTimeEffortDelta: taskEntity.manualTimeEffortDelta,
          );
          subTaskModels.add(taskModel);
          idToSubTasks
              .putIfAbsent(taskEntity.parentTaskId, () => [])
              .add(taskModel);
        }

        // Add the sub-subtasks (tier 3 and deeper) to their parents (tier-2)
        for (Task subtask in subTaskModels) {
          subtask.children = (idToSubTasks[subtask.id] ?? []);
        }
        return idToSubTasks;
      });
    });
  }
}
