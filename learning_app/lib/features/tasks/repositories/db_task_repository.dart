import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/database/database.dart' as db;

/// Concrete repository implementation using the database with drift
@Injectable(as: TaskRepository)
class DbTaskRepository implements TaskRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final TasksDao _dao = getIt<TasksDao>();

  @override
  Future<List<ListReadTaskDto>> loadTasks() async {
    return _dao.getAllTasks().map((task) {
      return ListReadTaskDto(
        id: task.id,
        title: task.title,
        done: task.done,
        categoryColor: Color(task.categoryColor),
        keywords: const ['Hausaufgabe', 'Lernen'], // TODO: implement
        remainingTimeEstimation: task.remainingTimeEstimation,
        dueDate: task.dueDate,
        subTaskCount: task.subTaskCount,
        finishedSubTaskCount: task.finishedSubTaskCount,
      );
    }).get();
  }

  @override

  /// Creates a new task and returns it with its newly generated id
  Future<int> createTask(CreateTaskDto newTask) async {
    return _dao.createTask(db.TasksCompanion(
      // For NOT NULL attributes, ofNullable() is used
      // For nullable attributes, use Value() instead
      // Reason: it could not be determined, if a null value in the DTO would
      // mean a Value.absent() or a Value(null)
      title: Value.ofNullable(newTask.title),
      description: Value(newTask.description),
      estimatedTime: Value(newTask.estimatedTime),
      dueDate: Value.ofNullable(newTask.dueDate),
      creationDateTime: Value(DateTime.now()),
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
    final affected = await _dao.deleteTaskById(id);
    return affected > 0;
  }

  @override
  Future<bool> toggleDone(int id) async {
    return _dao.toggleTaskDoneById(id).then((value) => value > 0);
  }
}
