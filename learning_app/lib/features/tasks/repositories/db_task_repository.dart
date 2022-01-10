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

/// Concrete repository implementation using the database with drift
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

  Stream<List<TaskWithQueueStatus>>? _taskWithQueueStatusStream;
  Stream<TaskAssociations>? _taskAssociationsStream;

  @override
  Stream<List<TaskWithQueueStatus>> watchTasks({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    _taskWithQueueStatusStream = _taskWithQueueStatusStream ??
        (_buildListStream(
          taskFilter: taskFilter,
          taskOrder: taskOrder,
        ));
    return _taskWithQueueStatusStream as Stream<List<TaskWithQueueStatus>>;
  }

  // Stream<List<TaskWithQueueStatus>> watchQueuedTasks(){
  //   return watchTasks()
  // }
  //
  // Stream<TaskWithQueueStatus> watchQueuedTaskWithId({required int id}){
  //
  // }

  @override
  Future<int> createTask(CreateTaskDto newTask) async {
    return _tasksDao.createTask(db.TasksCompanion(
      // For NOT NULL attributes, ofNullable() is used
      // For nullable attributes, use Value() instead
      // Reason: it could not be determined, if a null value in the DTO would
      // mean a Value.absent() or a Value(null)
      title: Value(newTask.title ?? 'Aufgabe ohne Titel'),
      description: Value(newTask.description),
      estimatedTime: Value(newTask.estimatedTime),
      dueDate: Value.ofNullable(newTask.dueDate),
      creationDateTime: Value(DateTime.now()),
      manualTimeEffortDelta:
          const Value(Duration.zero), // only changeable later
    ));
  }

  @override
  Future<bool> update(int id, UpdateTaskDto updateDto) async {
    //TODO
    // var db = await DbProvider().database;
    // var affected = await db.update('tasks', updateDto.toMap(), where: 'id = ?',whereArgs: [id],);
    // return affected > 0;
    return false;
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

  Stream<TaskAssociations> getAssociationsStream() {
    _taskAssociationsStream =
        _taskAssociationsStream ?? _buildTaskAssociationsStream();
    return _taskAssociationsStream as Stream<TaskAssociations>;
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

  /// Actually creates the stream. To be called only once.
  Stream<List<TaskWithQueueStatus>> _buildListStream({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    // All top level tasks that match the filters
    // The Keyword-Filter is not applied here, since it depends on a many to many join
    // It will be handled below
    final Stream<List<TaskEntity>> sortedFilteredTopLevelTasksStream =
        _tasksDao.watchFilteredAndSortedTopLevelTaskEntities(
            taskFilter: taskFilter, taskOrder: taskOrder);

    // switchMap is used to create a new sub-stream
    // (that uses the most recent values of the top-level stream),
    // whenever the top-level stream emits a new item.
    // The older stream will be automatically destroyed.

    // This will be called whenever some of the associations change:
    return getAssociationsStream().switchMap((associations) {
      // This will be called whenever the tasks change:
      return sortedFilteredTopLevelTasksStream.switchMap((topLevels) {
        // We also need the sub-tasks:
        final subLevelTasksStream = _tasksDao.watchSubLevelTaskEntities();

        // Merge it all together and build a stream of task-models
        return subLevelTasksStream.map((subLevels) {
          return _mergeEntitiesTogether(
            topLevels: topLevels,
            subLevels: subLevels,
            idToCategoryMap: associations.idToCategoryMap,
            taskIdToKeywordMap: associations.taskIdToKeywordsMap,
            keywordsFilter: taskFilter.keywords,
            taskIdToTimeLogsMap: associations.taskIdToTimeLogsMap,
            taskIdToQueueStatusMap: associations.taskIdToQueueStatusMap,
            taskIdToLearnListMap: associations.taskIdToLearnListMap,
          );
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

  /// Create the list of tasks with their queue status by merging everything
  ///
  /// Since the keywords for the tasks are only known here, the keywords-filter
  /// also is applied here, instead of as part of the tasks-query.
  /// This will only delay this, if the filter is present, though.
  List<TaskWithQueueStatus> _mergeEntitiesTogether({
    required List<TaskEntity> topLevels,
    required List<TaskEntity> subLevels,
    required Map<int, Category> idToCategoryMap,
    required Map<int, List<KeyWord>> taskIdToKeywordMap,
    required Value<List<KeyWord>> keywordsFilter,
    required Map<int, List<TimeLog>> taskIdToTimeLogsMap,
    required Map<int, QueueStatus> taskIdToQueueStatusMap,
    required Map<int, List<LearnList>> taskIdToLearnListMap,
  }) {
    final subTaskModels = [];
    final idToSubTasks = <int?, List<Task>>{};

    // Create the models for subtasks and maps them to their parent-ID
    for (var taskEntity in subLevels) {
      final taskModel = Task(
        id: taskEntity.id,
        title: taskEntity.title,
        doneDateTime: taskEntity.doneDateTime,
        description: taskEntity.description,
        category: idToCategoryMap[taskEntity.categoryId],
        keywords: taskIdToKeywordMap[taskEntity.id] ?? [],
        timeLogs: taskIdToTimeLogsMap[taskEntity.id] ?? [],
        estimatedTime: taskEntity.estimatedTime,
        dueDate: taskEntity.dueDate,
        creationDateTime: taskEntity.creationDateTime,
        children: const [],
        // children is supposed to be empty here. It will
        // be added below, since the "idToSubTasks" Map is required that does
        // not exist right here
        learnLists: taskIdToLearnListMap[taskEntity.id] ?? [],
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

    // Create the models for top-tier tasks
    final tasksWithQueueStatus = topLevels
        .map((taskEntity) => TaskWithQueueStatus(
              task: Task(
                id: taskEntity.id,
                title: taskEntity.title,
                doneDateTime: taskEntity.doneDateTime,
                description: taskEntity.description,
                category: idToCategoryMap[taskEntity.categoryId],
                keywords: taskIdToKeywordMap[taskEntity.id] ?? [],
                timeLogs: taskIdToTimeLogsMap[taskEntity.id] ?? [],
                estimatedTime: taskEntity.estimatedTime,
                dueDate: taskEntity.dueDate,
                creationDateTime: taskEntity.creationDateTime,
                children: const [],
                // children is supposed to be empty here. It will
                // be added below, since the "idToSubTasks" Map is required that does
                // not exist right here
                learnLists: taskIdToLearnListMap[taskEntity.id] ?? [],
                manualTimeEffortDelta: taskEntity.manualTimeEffortDelta,
              ),
              queueStatus: taskIdToQueueStatusMap[taskEntity.id],
            ))
        .toList();

    // Add the sub-tasks (tier 2) to their parents (top tier)
    for (TaskWithQueueStatus taskWithQueue in tasksWithQueueStatus) {
      taskWithQueue.task.children = (idToSubTasks[taskWithQueue.task.id] ?? []);
    }

    if (keywordsFilter.present) {
      // Apply the keywords-filter
      return tasksWithQueueStatus.where((taskWithQueue) {
        final wantedKeywords = keywordsFilter.value;
        final actualKeywords = taskWithQueue.task.keywords;
        // accept, if at least one of the wanted is found
        return wantedKeywords.any((wanted) {
          return actualKeywords.contains(wanted);
        });
      }).toList();
    } else {
      return tasksWithQueueStatus;
    }
  }
}
