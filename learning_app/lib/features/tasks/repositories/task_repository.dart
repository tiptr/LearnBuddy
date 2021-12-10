import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/util/database.dart';

class TaskRepository {
  Future<Task> insertTask(Task task) async {
    var db = await DbProvider().database;

    var id = await db.insert('tasks', task.toMap());
    task.id = id;

    return task;
  }

  Future<List<Task>> loadTasks() async {
    var db = await DbProvider().database;
    var taskMaps = await db.query('tasks');

    return List.generate(taskMaps.length, (i) {
      var task = Task(
        title: taskMaps[i]['title'] as String,
        done: taskMaps[i]['done'] == 1 ? true : false,
      );

      task.id = taskMaps[i]['id'] as int;

      return task;
    });
  }

  Future<void> update(Task task) async {
    var db = await DbProvider().database;

    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> delete(int id) async {
    var db = await DbProvider().database;

    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
