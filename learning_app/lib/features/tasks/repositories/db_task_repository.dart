import 'package:injectable/injectable.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/database.dart';
import 'package:learning_app/util/injection.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: TaskRepository)
class DbTaskRepository implements TaskRepository{

  // load the database (with generated entities and queries) via dependency inj.
  final Database _db = getIt<Database>();

  @override
  Future<List<Task>> loadTasks() async {

    return _db.getAll().get();

    // var db = await DbProvider().database;
    // var taskMaps = await db.query('tasks');
    //
    // return List.generate(taskMaps.length, (i) {
    //   var task = Task(
    //     id: taskMaps[i]['id'] as int,
    //     title: taskMaps[i]['title'] as String,
    //     done: taskMaps[i]['done'] == 1 ? true : false,
    //   );
    //
    //   return task;

    // });
    return List.empty();
  }

  @override
  Future<Task> createTask(CreateTaskDto taskDto) async {

    final id = await _db.createEntry(taskDto.title);

    return Task(id: id, title: taskDto.title, done: taskDto.done);

    // var db = await DbProvider().database;
    //
    // var id = await db.insert('tasks', taskDto.toMap());
    // return Task(id: id, title: taskDto.title, done: taskDto.done);

    // return const Task(id: 999, title: 'Abc', done: false);
  }

  @override
  Future<bool> update(int id, UpdateTaskDto updateDto) async {
    // var db = await DbProvider().database;
    //
    // var affected = await db.update(
    //   'tasks',
    //   updateDto.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [id],
    // );
    //
    // return affected > 0;

    return false;
  }

  @override
  Future<bool> deleteById(int id) async {
    // var db = await DbProvider().database;
    //
    // var affected = await db.delete(
    //   'tasks',
    //   where: 'id = ?',
    //   whereArgs: [id],
    // );
    //
    // return affected > 0;

    return false;
  }
}
