import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';

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

  Stream<List<TaskEntity>>? _filteredSortedTopLevelTaskEntitiesStream;
  Stream<List<TaskEntity>>? _subLevelTaskEntitiesStream;
  // Stream<Map<int?, List<TaskEntity>>>? _idToSubTaskEntitiesStream;

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

  Stream<List<TaskEntity>> watchSubLevelTaskEntities() {
    _subLevelTaskEntitiesStream =
        (_subLevelTaskEntitiesStream ?? _createSubLevelTaskEntitiesStream());

    return _subLevelTaskEntitiesStream as Stream<List<TaskEntity>>;
  }

  Stream<List<TaskEntity>> watchFilteredAndSortedTopLevelTaskEntities({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    _filteredSortedTopLevelTaskEntitiesStream =
        (_filteredSortedTopLevelTaskEntitiesStream ??
            (_createFilteredAndSortedTopLevelTaskEntitiesStream(
              taskFilter: taskFilter,
              taskOrder: taskOrder,
            )));

    return _filteredSortedTopLevelTaskEntitiesStream
        as Stream<List<TaskEntity>>;
  }

  // /// Returns a stream of maps that associate the parent id with its children
  // ///
  // /// There only ever will exist one of this streams in parallel.
  // Stream<Map<int?, List<TaskEntity>>> watchParentIdToSubTaskEntitiesMap() {
  //   _idToSubTaskEntitiesStream =
  //   (_idToSubTaskEntitiesStream ?? (_createParentIdToSubTasksMapStream()));
  //
  //   return _idToSubTaskEntitiesStream as Stream<Map<int?, List<TaskEntity>>>;
  // }
  //
  // /// Creates a stream of maps that associate the parent id with its children
  // Stream<Map<int?, List<TaskEntity>>> _createParentIdToSubTasksMapStream() {
  //   final Stream<List<TaskEntity>> subTasksStream = watchSubLevelTaskEntities();
  //
  //   return subTasksStream.map((subLevels) {
  //     final subTaskModels = [];
  //     final idToSubTasks = <int?, List<Task>>{};
  //
  //     // Create the models for subtasks and maps them to their parent-ID
  //     for (var taskEntity in subLevels) {
  //       final taskModel = Task(
  //         id: taskEntity.id,
  //         title: taskEntity.title,
  //         doneDateTime: taskEntity.doneDateTime,
  //         description: taskEntity.description,
  //         category: idToCategoryMap[taskEntity.categoryId],
  //         keywords: taskIdToKeywordMap[taskEntity.id] ?? [],
  //         timeLogs: taskIdToTimeLogsMap[taskEntity.id] ?? [],
  //         estimatedTime: taskEntity.estimatedTime,
  //         dueDate: taskEntity.dueDate,
  //         creationDateTime: taskEntity.creationDateTime,
  //         children: const [], // children is supposed to be empty here. It will
  //         // be added below, since the "idToSubTasks" Map is required that does
  //         // not exist right here
  //         learnLists: taskIdToLearnListMap[taskEntity.id] ?? [],
  //         manualTimeEffortDelta: taskEntity.manualTimeEffortDelta,
  //       );
  //       subTaskModels.add(taskModel);
  //       idToSubTasks
  //           .putIfAbsent(taskEntity.parentTaskId, () => [])
  //           .add(taskModel);
  //     }
  //
  //     // Add the sub-subtasks (tier 3 and deeper) to their parents (tier-2)
  //     for (Task subtask in subTaskModels) {
  //       subtask.children = (idToSubTasks[subtask.id] ?? []);
  //     }
  //
  //
  //
  //     final idToModel = <int, Category>{};
  //     for (var model in models) {
  //       idToModel.putIfAbsent(model.id, () => model);
  //     }
  //     return idToModel;
  //   });
  // }

  Stream<List<TaskEntity>> _createSubLevelTaskEntitiesStream() {
    final subLevelTasksQuery = select(tasks)
      ..where((tsk) => tsk.parentTaskId.isNotNull()); // sub-levels only
    return subLevelTasksQuery.watch();
  }

  /// Creates a stream that watches the top-level tasks matching the given filter
  Stream<List<TaskEntity>> _createFilteredAndSortedTopLevelTaskEntitiesStream({
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
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
