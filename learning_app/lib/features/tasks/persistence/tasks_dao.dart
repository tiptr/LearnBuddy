import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
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
    include: {
      'package:learning_app/features/tasks/persistence/tasks.drift'
    }, queries: {
  'tasksWithQueueStatus': '''
         SELECT *
         FROM Tasks t
         JOIN Categories c ON t.category_id = c.id
         WHERE t.parent_task_id IS NULL;
        '''
})
class TasksDao extends DatabaseAccessor<Database>
    with _$TasksDaoMixin {
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

  Future<List<ListReadTaskDto>> getAllTasks() {
    final query = select(tasks).map((row) =>
        ListReadTaskDto(
          id: row.id,
          title: row.title,
          done: row.doneDateTime != null,
          // TODO
          categoryColor: Colors.amber,
          subTaskCount: 2,
          finishedSubTaskCount: 1,
          isQueued: false,
          keywords: const ['Hausaufgabe', 'Lernen'],
          dueDate: row.dueDate,
          remainingTimeEstimation: row.estimatedTime, // TODO:
        ));
    return query.get();
  }

  Stream<List<ListReadTaskDto>> watchAllTasks() {
    final query = select(tasks).map((row) =>
        ListReadTaskDto(
          id: row.id,
          title: row.title,
          done: row.doneDateTime != null,
          // TODO
          categoryColor: Colors.amber,
          subTaskCount: 2,
          finishedSubTaskCount: 1,
          isQueued: false,
          keywords: const ['Hausaufgabe', 'Lernen'],
          dueDate: row.dueDate,
          remainingTimeEstimation: row.estimatedTime, // TODO:
        ));
    return query.watch();
  }

  // Stream<List<TaskWithQueueStatus>> watchTasks({ TODO
  Stream<List<TaskWithQueueStatus>> watchTasks({
    int? limit,
    int? offset,
    TaskFilter taskFilter = const TaskFilter(),
    TaskOrder taskOrder = const TaskOrder(),
  }) {
    // start by watching all top level tasks
    // that match the filters in any way
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
      })..where((tsk) {
        // category filter, if applied
        if (taskFilter.category.present) {
          return tsk.categoryId.equals(taskFilter.category.value?.id);
        } else {
          return const CustomExpression('TRUE');
        }
      })..where((tsk) {
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

    final sortedFilteredTopLevelTasksQuery = filteredTopLevelTasksQuery
      ..orderBy([
            (tsk) {
          Expression sortExpression;
          OrderingMode orderingMode;
          // Create the correct db-specific sort expression matching the
          // given domain-layer TaskOrder
          switch (taskOrder.attribute) {
            case TaskOrderAttributes.dueDate:
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

    return sortedFilteredTopLevelTasksQuery.watch().switchMap((topLevels) {
      final subLevelTasksQuery = select(tasks)
        ..where((tsk) => tsk.parentTaskId.isNotNull()); // sub-levels only

      return subLevelTasksQuery.watch().map((subLevels) {
        // // Create a map to efficiently get the subtasks
        // final parentIdToSubTaskMap = {
        //   for (var subLevel in subLevels) subLevel.parentTaskId: subLevel
        // };

        print('Size of subtasks: ${subLevels.length}');

        final subTaskModels = [];
        final idToSubTasks = <int?, List<Task>>{};

        // Create the models for subtasks and maps them to their parent-ID
        for (var taskEntity in subLevels) {
          final taskModel = Task(
            id: taskEntity.id,
            title: taskEntity.title,
            doneDateTime: taskEntity.doneDateTime,
            description: taskEntity.description,
            category: const Category(
              id: 0,
              name: 'Testkategorie',
              color: Colors.lightBlue,
            ),
            // TODO
            keywords: const [
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
          idToSubTasks.putIfAbsent(taskEntity.parentTaskId, () => []).add(
              taskModel);
        }

        print('Size of subtask-models: ${subTaskModels.length}');

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
                category: const Category(
                  id: 0,
                  name: 'Testkategorie',
                  color: Colors.lightBlue,
                ),
                // TODO
                keywords: const [
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
          taskWithQueue.task.children = (
              idToSubTasks[taskWithQueue.task.id] ?? []);
        }

        print('Size of tasks: ${tasksWithQueueStatus.length}');

        return tasksWithQueueStatus;



        // Allocate the subtasks to the top level tasks

        return [
          for (var taskEntity in topLevels)
            TaskWithQueueStatus(
              task: Task(
                id: taskEntity.id,
                title: taskEntity.title,
                doneDateTime: taskEntity.doneDateTime,
                description: taskEntity.description,
                category: const Category(
                  id: 0,
                  name: 'Testkategorie',
                  color: Colors.lightBlue,
                ),
                // TODO
                keywords: const [
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

        // final mappedQuery =
        // sortedFilteredTopLevelTasksQuery.map((row) =>
        //     ListReadTaskDto(
        //       id: row.id,
        //       title: row.title,
        //       done: row.doneDateTime != null,
        //       // TODO
        //       categoryColor: Colors.amber,
        //       subTaskCount: 2,
        //       finishedSubTaskCount: 1,
        //       isQueued: false,
        //       keywords: const ['Hausaufgabe', 'Lernen'],
        //       dueDate: row.dueDate,
        //       remainingTimeEstimation: row.estimatedTime, // TODO:
        //     ));
        //
        // Stream<List<ListReadTaskDto>> stream = mappedQuery.watch();
        //
        // return stream;
      });
    });
  }

  // Stream<List<ListReadTaskDto>> watchAllCarts() {
  //   // start by watching all carts
  //   final cartStream = select(shoppingCarts).watch();
  //
  //   return cartStream.switchMap((carts) {
  //     // this method is called whenever the list of carts changes. For each
  //     // cart, now we want to load all the items in it.
  //     // (we create a map from id to cart here just for performance reasons)
  //     final idToCart = {for (var cart in carts) cart.id: cart};
  //     final ids = idToCart.keys;
  //
  //     // select all entries that are included in any cart that we found
  //     final entryQuery = select(shoppingCartEntries).join(
  //       [
  //         innerJoin(
  //           buyableItems,
  //           buyableItems.id.equalsExp(shoppingCartEntries.item),
  //         )
  //       ],
  //     )..where(shoppingCartEntries.shoppingCart.isIn(ids));
  //
  //     return entryQuery.watch().map((rows) {
  //       // Store the list of entries for each cart, again using maps for faster
  //       // lookups.
  //       final idToItems = <int, List<BuyableItem>>{};
  //
  //       // for each entry (row) that is included in a cart, put it in the map
  //       // of items.
  //       for (var row in rows) {
  //         final item = row.readTable(buyableItems);
  //         final id = row.readTable(shoppingCartEntries).shoppingCart;
  //
  //         idToItems.putIfAbsent(id, () => []).add(item);
  //       }
  //
  //       // finally, all that's left is to merge the map of carts with the map of
  //       // entries
  //       return [
  //         for (var id in ids)
  //           ListReadTaskDto(id: 0,
  //             title: 'row.title',
  //           done: false,
  //           categoryColor: Colors.amber,
  //           subTaskCount: 2,
  //           finishedSubTaskCount: 1,
  //           isQueued: false,
  //           keywords: const ['Hausaufgabe', 'Lernen'],
  //           dueDate: DateTime.now(),
  //           remainingTimeEstimation: const Duration(minutes: 8)),
  //       ];
  //     });
  //   });
  // }

  // final subLevelTasksQuery = select(tasks)
  //   ..where((tsk) => tsk.parentTaskId.isNull()); // sub-levels only
  //
  // final currentSubTasks = subLevelTasksQuery.watch()
  // .
  //
  // final parentIdToSubTaskMap = {for (var subtask in ) cart.id: cart};
  //
  // // TODO: Keywords filter
  //
  //
  // // TODO: Map Keywords
  //
  // // TODO: Map Timelogs
  //
  // // TODO: Map children
  //
  // // TODO: Map learnlists ??
  //
  // // TODO: Map Queue
  //
  // final mappedQuery =
  // sortedFilteredTopLevelTasksQuery.map((row) => ListReadTaskDto(
  // id: row.id,
  // title: row.title,
  // done: row.doneDateTime != null,
  // // TODO
  // categoryColor: Colors.amber,
  // subTaskCount: 2,
  // finishedSubTaskCount: 1,
  // isQueued: false,
  // keywords: const ['Hausaufgabe', 'Lernen'],
  // dueDate: row.dueDate,
  // remainingTimeEstimation: row.estimatedTime, // TODO:
  // ));
  //
  // Stream<List<ListReadTaskDto>> stream = mappedQuery.
  // watch
  // (
  // );
  //
  // return
  // stream;

  // return cartStream.switchMap((carts) {
  //   // this method is called whenever the list of carts changes. For each
  //   // cart, now we want to load all the items in it.
  //   // (we create a map from id to cart here just for performance reasons)
  //   final idToCart = {for (var cart in carts) cart.id: cart};
  //   final ids = idToCart.keys;
  //
  //   // select all entries that are included in any cart that we found
  //   final entryQuery = select(shoppingCartEntries).join(
  //     [
  //       innerJoin(
  //         buyableItems,
  //         buyableItems.id.equalsExp(shoppingCartEntries.item),
  //       )
  //     ],
  //   )..where(shoppingCartEntries.shoppingCart.isIn(ids));
  //
  //   return entryQuery.watch().map((rows) {
  //     // Store the list of entries for each cart, again using maps for faster
  //     // lookups.
  //     final idToItems = <int, List<BuyableItem>>{};
  //
  //     // for each entry (row) that is included in a cart, put it in the map
  //     // of items.
  //     for (var row in rows) {
  //       final item = row.readTable(buyableItems);
  //       final id = row.readTable(shoppingCartEntries).shoppingCart;
  //
  //       idToItems.putIfAbsent(id, () => []).add(item);
  //     }
  //
  //     // finally, all that's left is to merge the map of carts with the map of
  //     // entries
  //     return [
  //       for (var id in ids)
  //         CartWithItems(idToCart[id], idToItems[id] ?? []),
  //     ];
  //   });
  // });

  // final query = select(tasks).map((row) => ListReadTaskDto(
  //       id: row.id,
  //       title: row.title,
  //       done: row.doneDateTime != null,
  //       // TODO
  //       categoryColor: Colors.amber,
  //       subTaskCount: 2,
  //       finishedSubTaskCount: 1,
  //       isQueued: false,
  //       keywords: const ['Hausaufgabe', 'Lernen'],
  //       dueDate: row.dueDate,
  //       remainingTimeEstimation: row.estimatedTime, // TODO:
  //     ));
  // return query.watch();

  Future<int> deleteTaskById(int taskId) {
    return (delete(tasks)
      ..where((t) => t.id.equals(taskId))).go();
  }

  Future<int> toggleTaskDoneById(int taskId, bool done) {
    Value<DateTime?> newDoneDateTime = const Value(null);

    if (done) {
      newDoneDateTime = Value(DateTime.now());
    }

    return (update(tasks)
      ..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        doneDateTime: newDoneDateTime,
      ),
    );
  }

// Stream<List<Task>> getTasks(int limit, {int? offset}) {
//   var a = (select(tasks)
//     ..limit(limit, offset: offset)).get();
//
//   var b = customSelect(
//     'SELECT COUNT(*) AS c FROM todos WHERE category = ?',
//     variables: [Variable.withInt(id)],
//     readsFrom: {tasks},
//   ).map((row) => row.readInt('c')).watch();
// }

}
