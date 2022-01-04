import 'package:injectable/injectable.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: TaskRepository)
class DbTaskRepository implements TaskRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final TasksDao _dao = getIt<TasksDao>();

  @override
  Future<List<Task>> loadTasks() async {
    return _dao.getAll().get();
  }

  @override
  Future<Task> createTask(CreateTaskDto taskDto) async {
    final id = await _dao.createEntry(taskDto.title);
    return Task(id: id, title: taskDto.title, done: taskDto.done);
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
    final affected = await _dao.deleteById(id);
    return affected > 0;
  }

  @override
  Future<bool> toggleDone(int id) async {
    return _dao.toggleDoneById(id).then((value) => value > 0);
  }
}
