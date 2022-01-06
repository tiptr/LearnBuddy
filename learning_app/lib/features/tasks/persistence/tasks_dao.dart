import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

part 'tasks_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definition
  include: {'package:learning_app/features/tasks/persistence/tasks.drift'},
)
class TasksDao extends DatabaseAccessor<Database> with _$TasksDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TasksDao(Database db) : super(db);

  /// Creates a new task and returns its id.
  ///
  /// Takes a TasksCompanion rather than a task. This is auto-generated and
  /// here allows to define only required values that are not auto-generated
  /// like the ID.
  Future<int> createTask(TasksCompanion tasksCompanion) {
    // insertReturning() already provides the whole created entity instead of
    // the single ID provided by insert()
    // this was changed back to insert(), because now, we do not need the 'task'
    // anymore for displaying the list, but rather a 'ListReadTaskDto'

    return into(tasks).insert(tasksCompanion);
  }

  Future<int> deleteTaskById(int taskId) {
    return (delete(tasks)..where((t) => t.id.equals(taskId))).go();
  }

  Future<int> toggleTaskDoneById(int taskId, bool done) {
    Value<DateTime?> newDoneDateTime = const Value(null);

    if (done) {
      newDoneDateTime = Value(DateTime.now());
    }

    return (update(tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        doneDateTime: newDoneDateTime,
      ),
    );
  }

  // Stream<List<TaskWithQueueStatus>> watchTasks({ TODO
  Stream<List<TaskWithQueueStatus>> watchTasks({
    int? limit,
    int? offset,
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    // All top level tasks that match the filters
    // The Keyword-Filter is not applied here, since it depends on a many to many join
    // It will be handled below
    final Stream<List<TaskEntity>> sortedFilteredTopLevelTasksStream =
        _getFilteredAndSortedTopLevelTasksStream(taskFilter, taskOrder);

    final Stream<List<CategoryEntity>> categoriesStream =
        select(categories).watch();

    // switchMap is used to create a new sub-stream
    // (that uses the most recent values of the top-level stream),
    // whenever the top-level stream emits a new item.
    // The older stream will be automatically destroyed.

    // ->  Start with the streams that will change less often, so that for the
    // more recent changing streams, not everything has to be rebuild

    // This will be called whenever the categories change:
    return categoriesStream.switchMap((categories) {
      // Create a map to efficiently allocate the categories
      // this maps are generated as low in the stream-chain as possible, so
      // they will not have to be created at every update in the inner chain
      final idToCategoryMap = createIdToCategoryMapFromEntities(categories);

      // This will be called whenever the tasks change:
      return sortedFilteredTopLevelTasksStream.switchMap((topLevels) {
        // We also need the sub-tasks:
        final subLevelTasksQuery = select(tasks)
          ..where((tsk) => tsk.parentTaskId.isNotNull()); // sub-levels only

        // Merge it all together and build a stream of task-models
        return subLevelTasksQuery.watch().map((subLevels) {
          return mergeEntitiesTogether(
            topLevels: topLevels,
            subLevels: subLevels,
            idToCategoryMap: idToCategoryMap,
          );
        });
      });
    });
  }

  // // TODO: Keywords filter
  // // TODO: Map Keywords
  // // TODO: Map Timelogs
  // // TODO: Map learnlists ??
  // // TODO: Map Queue

  Map<int, Category> createIdToCategoryMapFromEntities(
      List<CategoryEntity> categoryEntities) {
    final idToCategory = <int, Category>{};
    for (var categoryEntity in categoryEntities) {
      final categoryModel = Category(
        id: categoryEntity.id,
        name: categoryEntity.name,
        color: categoryEntity.color,
      );
      idToCategory.putIfAbsent(categoryModel.id, () => categoryModel);
    }
    return idToCategory;
  }

  /// Create the list of tasks with their queue status by merging everything
  List<TaskWithQueueStatus> mergeEntitiesTogether(
      {required List<TaskEntity> topLevels,
      required List<TaskEntity> subLevels,
      required Map<int, Category> idToCategoryMap}) {
    // // Create a map to efficiently get the subtasks
    // final parentIdToSubTaskMap = {
    //   for (var subLevel in subLevels) subLevel.parentTaskId: subLevel
    // };

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
        keywords: const [
          // TODO
          KeyWord(id: 0, name: 'Hausaufgabe'),
          KeyWord(id: 1, name: 'Lernen'),
        ],
        // TODO
        timeLogs: const [],
        // TODO
        estimatedTime: taskEntity.estimatedTime,
        dueDate: taskEntity.dueDate,
        creationDateTime: taskEntity.creationDateTime,
        children: const [],
        // TODO
        learnLists: const [],
        // TODO
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
    final tasksWithQueueStatus = [
      for (var taskEntity in topLevels)
        TaskWithQueueStatus(
          task: Task(
            id: taskEntity.id,
            title: taskEntity.title,
            doneDateTime: taskEntity.doneDateTime,
            description: taskEntity.description,
            category: idToCategoryMap[taskEntity.categoryId],
            keywords: const [
              // TODO
              KeyWord(id: 0, name: 'Hausaufgabe'),
              KeyWord(id: 1, name: 'Lernen'),
            ],
            // TODO
            timeLogs: const [],
            // TODO
            estimatedTime: taskEntity.estimatedTime,
            dueDate: taskEntity.dueDate,
            creationDateTime: taskEntity.creationDateTime,
            children: const [],
            // TODO
            learnLists: const [],
            // TODO
            manualTimeEffortDelta: taskEntity.manualTimeEffortDelta,
          ),
          isQueued: false,
        ),
    ];

    // Add the sub-tasks (tier 2) to their parents (top tier)
    for (TaskWithQueueStatus taskWithQueue in tasksWithQueueStatus) {
      taskWithQueue.task.children = (idToSubTasks[taskWithQueue.task.id] ?? []);
    }

    return tasksWithQueueStatus;
  }

  /// Creates a stream that watches the top-level tasks matching the given filter
  Stream<List<TaskEntity>> _getFilteredAndSortedTopLevelTasksStream(
      TaskFilter taskFilter, TaskOrder taskOrder) {
    // Create the query to get filtered top level tasks:
    final filteredTopLevelTasksQuery = select(tasks)
      ..where((tsk) => tsk.parentTaskId.isNull()) // top-level only
      ..where((tsk) {
        // done filter, if applied
        if (taskFilter.done.present) {
          if (taskFilter.done.value == true) {
            return tsk.doneDateTime.isNotNull();
          } else {
            // Task = not done <=> not set to done or set at this day
            return tsk.doneDateTime.isNull() |
                // currentDate -> midnight, when the day began
                tsk.doneDateTime.isBiggerOrEqual(currentDate);
          }
        } else {
          return const CustomExpression('TRUE');
        }
      })
      ..where((tsk) {
        // category filter, if applied
        if (taskFilter.category.present) {
          return tsk.categoryId.equals(taskFilter.category.value?.id);
        } else {
          return const CustomExpression('TRUE');
        }
      })
      ..where((tsk) {
        // overDue filter, if applied
        if (taskFilter.overDue.present) {
          if (taskFilter.overDue.value == true) {
            return // currentDate -> midnight, when the day began
                tsk.dueDate.isSmallerThan(currentDate);
          } else {
            return tsk.dueDate.isNull() |
                // currentDate -> midnight, when the day began
                tsk.dueDate.isBiggerOrEqual(currentDate);
          }
        } else {
          return const CustomExpression('TRUE');
        }
      });

    // Add ordering to the exixting query
    final sortedFilteredTopLevelTasksQuery = filteredTopLevelTasksQuery
      ..orderBy([
        (tsk) {
          Expression sortExpression;
          OrderingMode orderingMode;
          // Create the correct db-specific sort expression matching the
          // given domain-layer TaskOrder
          switch (taskOrder.attribute) {
            case TaskOrderAttributes.dueDate:
              // TODO: this is inspiration for a later fix of the null ordering (currently, NULL is not last when ordering asc, as it should be)
              // if (taskOrder.direction == OrderDirection.asc) {
              //   sortExpression =
              //       const CustomExpression('due_date NULLS LAST');
              // } else {
              //   sortExpression =
              //       const CustomExpression('due_date NULLS FIRST');
              // }
              sortExpression = tsk.dueDate;
              break;
            case TaskOrderAttributes.creationDate:
              sortExpression = tsk.creationDateTime;
              break;
            case TaskOrderAttributes.doneDate:
              sortExpression = tsk.doneDateTime;
              break;
            case TaskOrderAttributes.title:
              sortExpression = tsk.title;
              break;
          }
          switch (taskOrder.direction) {
            case OrderDirection.asc:
              orderingMode = OrderingMode.asc;
              break;
            case OrderDirection.desc:
              orderingMode = OrderingMode.desc;
              break;
          }
          return OrderingTerm(expression: sortExpression, mode: orderingMode);
        },
      ]);

    return sortedFilteredTopLevelTasksQuery.watch();
  }
}
