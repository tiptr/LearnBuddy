import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';

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

  Future<List<ListReadTaskDto>> getAllTasks() {
    final query = select(tasks).map((row) => ListReadTaskDto(
          id: row.id,
          title: row.title,
          done: row.done,
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
    final query = select(tasks).map((row) => ListReadTaskDto(
          id: row.id,
          title: row.title,
          done: row.done,
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

  Future<int> deleteTaskById(int taskId) {
    return (delete(tasks)..where((t) => t.id.equals(taskId))).go();
  }

  Future<int> toggleTaskDoneById(int taskId, bool done) {
    return (update(tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        done: Value(done),
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
