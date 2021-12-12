import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';

class TaskCubit extends Cubit<List<Task>> {
  final _repository = TaskRepository();

  TaskCubit() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    var aufgaben = await _repository.fetchTasks();
    emit(aufgaben);
  }

  // Toggles the done flag in a aufgabe in the cubit state
  Future<void> toggleDone(Task aufgabe) async {
    aufgabe.done = !aufgabe.done;
    await _repository.update(aufgabe);

    int index = state.indexWhere((Task t) => t.id == aufgabe.id);
    state[index] = aufgabe;

    emit(state.toList());
  }

  Future<void> createTask(String title) async {
    var aufgabeData = Task(title: title, done: false);
    var createdTask = await _repository.insertTask(aufgabeData);

    emit(state + [createdTask]);
  }

  Future<void> deleteTask(int id) async {
    await _repository.delete(id);

    emit(state.where((element) => element.id != id).toList());
  }
}
