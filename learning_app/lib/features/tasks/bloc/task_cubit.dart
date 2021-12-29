import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/logger.dart';
import 'package:logger/logger.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(InitialTaskState());

  @override
  TaskState get state {
    return super.state ?? InitialTaskState();
  }

  // Future<void> loadTasks() async {
  //   emit(TaskLoading());
  //   var tasks = await _taskRepository.loadTasks();
  //   emit(TasksLoaded(tasks: tasks));
  // }

  Future<void> createTask(CreateTaskDto createTaskDto) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var createdTask = await _taskRepository.createTask(createTaskDto);

      // Create a deep copy so the actual state isn't mutated
      var tasks = List<Task>.from(currentState.tasks);

      emit(TasksLoaded(tasks: tasks + [createdTask]));
    }
  }

  // Toggles the done flag in a task in the cubit state
  Future<void> toggleDone(Task task) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var updateDto = UpdateTaskDto(title: task.title, done: !task.done);

      var success = await _taskRepository.update(task.id, updateDto);
      if (!success) return;

      // Create a deep copy so the actual state isn't mutated
      var tasks = List<Task>.from(currentState.tasks);
      int index = tasks.indexWhere((Task t) => t.id == task.id);
      tasks[index] = Task(id: task.id, title: task.title, done: !task.done);

      emit(TasksLoaded(tasks: tasks));
    }
  }

  Future<void> deleteTaskById(int id) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var success = await _taskRepository.deleteById(id);
      if (!success) return;

      // Create a deep copy so the actual state isn't mutated
      var tasks = List<Task>.from(currentState.tasks);

      tasks = tasks.where((element) => element.id != id).toList();
      emit(TasksLoaded(tasks: tasks));
    }
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {

    // final tasks = json['tasks'];
    //
    // return TasksLoaded(
    //     tasks:
    // );
    logger.log(Level.debug, 'Loaded tasks: JSON: ${json}');
    logger.log(Level.debug, 'Loaded tasks: TasksLoaded: ${TasksLoaded.fromJson(json)}');

    return TasksLoaded.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    final tasksLoaded = state as TasksLoaded;
    return tasksLoaded.toJson();
  }
}
