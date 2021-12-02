import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/todo/models/todo.dart';

class TodosCubit extends Cubit<List<Todo>> {
  TodosCubit()
      : super(
          [
            Todo(title: "Todo 1", done: true),
            Todo(title: "Todo 2", done: false),
            Todo(title: "Todo 3", done: true),
            Todo(title: "Todo 4", done: false),
          ],
        );

  // Adds a new todo to the cubit state
  void add(Todo todo) => emit(state + [todo]);

  // Toggles the done flag in a todo in the cubit state
  void toggle(Todo todo) {
    var newState = state;
    int index = state.indexWhere((Todo t) => t == todo);
    newState[index].done = !newState[index].done;

    emit(state.toList());
  }
}
