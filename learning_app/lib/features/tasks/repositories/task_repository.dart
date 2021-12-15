import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/util/database.dart';

class TaskRepository {
  Future<List<Task>> loadTasks() async {
    var db = await DbProvider().database;
    var taskMaps = await db.query('tasks');

    return List.generate(taskMaps.length, (i) {
      var task = Task(
        id: taskMaps[i]['id'] as int,
        title: taskMaps[i]['title'] as String,
        done: taskMaps[i]['done'] == 1 ? true : false,
      );

      return task;
    });
  }

  Future<Task> createTask(CreateTaskDto taskDto) async {
    var db = await DbProvider().database;

    var id = await db.insert('tasks', taskDto.toMap());
    return Task(id: id, title: taskDto.title, done: taskDto.done);
  }

  Future<bool> update(int id, UpdateTaskDto updateDto) async {
    var db = await DbProvider().database;

    var affected = await db.update(
      'tasks',
      updateDto.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return affected > 0;
  }

  Future<bool> deleteById(int id) async {
    var db = await DbProvider().database;

    var affected = await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    return affected > 0;
  }
}
