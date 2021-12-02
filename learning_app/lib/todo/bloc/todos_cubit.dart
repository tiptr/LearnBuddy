import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/todo/models/todo.dart';
import 'package:learning_app/todo/repositories/todo_repository.dart';

class TodosCubit extends Cubit<List<Todo>> {
  final _repository = TodoRepository();

  TodosCubit() : super([]);

  Future<void> loadTodos() async {
    var todos = await _repository.fetchTodos();
    emit(todos);
  }

  // Toggles the done flag in a todo in the cubit state
  Future<void> updateTodo(Todo todo) async {
    todo.done = !todo.done;
    await _repository.update(todo);

    int index = state.indexWhere((Todo t) => t.id == todo.id);
    state[index] = todo;

    emit(state.toList());
  }

  Future<void> createTodo(String title) async {
    var todoData = Todo(title: title, done: false);
    var createdTodo = await _repository.insertTodo(todoData);

    emit(state + [createdTodo]);
  }

  Future<void> deleteTodo(int id) async {
    await _repository.delete(id);

    emit(state.where((element) => element.id != id).toList());
  }
}
