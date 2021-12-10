import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(InitialTaskState());

  Future<void> loadTasks() async {
    emit(TaskLoading());
    var tasks = await _taskRepository.loadTasks();
    emit(TasksLoaded(tasks: tasks));
  }

  Future<void> createTask(CreateTaskDto createTaskDto) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      emit(TaskLoading());
      var createdTask = await _taskRepository.createTask(createTaskDto);
      emit(TasksLoaded(tasks: currentState.tasks + [createdTask]));
    }
  }

  // Toggles the done flag in a task in the cubit state
  Future<void> toggleDone(Task task) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      emit(TaskLoading());
      var updateDto = UpdateTaskDto(title: task.title, done: !task.done);

      var success = await _taskRepository.update(task.id, updateDto);
      if (!success) return;

      var tasks = currentState.tasks;
      int index = tasks.indexWhere((Task t) => t.id == task.id);
      tasks[index] = Task(id: task.id, title: task.title, done: !task.done);

      emit(TasksLoaded(tasks: tasks));
    }
  }

  Future<void> deleteTaskById(int id) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      emit(TaskLoading());
      var success = await _taskRepository.deleteById(id);
      if (!success) return;

      var tasks =
          currentState.tasks.where((element) => element.id != id).toList();
      emit(TasksLoaded(tasks: tasks));
    }
  }
}
