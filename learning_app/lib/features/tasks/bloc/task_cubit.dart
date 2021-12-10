import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_state.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(InitialTaskState()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    var tasks = await _taskRepository.loadTasks();
    emit(TasksLoaded(tasks: tasks));
  }

  // Toggles the done flag in a aufgabe in the cubit state
  Future<void> toggleDone(Task aufgabe) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      aufgabe.done = !aufgabe.done;
      await _taskRepository.update(aufgabe);

      var tasks = currentState.tasks;
      int index = tasks.indexWhere((Task t) => t.id == aufgabe.id);
      tasks[index] = aufgabe;

      emit(TasksLoaded(tasks: tasks));
    }
  }

  Future<void> createTask(String title) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var aufgabeData = Task(title: title, done: false);
      var createdTask = await _taskRepository.insertTask(aufgabeData);

      emit(TasksLoaded(tasks: currentState.tasks + [createdTask]));
    }
  }

  Future<void> deleteTask(int id) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      await _taskRepository.delete(id);

      var tasks =
          currentState.tasks.where((element) => element.id != id).toList();
      emit(TasksLoaded(tasks: tasks));
    }
  }
}
