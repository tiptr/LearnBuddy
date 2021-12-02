import 'package:learning_app/todo/models/todo.dart';
import 'package:learning_app/util/database.dart';

class TodoRepository {
  Future<Todo> insertTodo(Todo todo) async {
    var db = await DbProvider().database;

    var id = await db.insert('todos', todo.toMap());
    todo.id = id;

    return todo;
  }

  Future<List<Todo>> fetchTodos() async {
    var db = await DbProvider().database;
    var todoMaps = await db.query('todos');

    var todos = List.generate(todoMaps.length, (i) {
      var todo = Todo(
        title: todoMaps[i]['title'] as String,
        done: todoMaps[i]['done'] == 1 ? true : false,
      );

      todo.id = todoMaps[i]['id'] as int;

      return todo;
    });

    todos.forEach((element) {
      print(element);
    });

    return todos;
  }

  Future<void> update(Todo todo) async {
    var db = await DbProvider().database;

    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(int id) async {
    var db = await DbProvider().database;

    await db.delete(
      'todos',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
