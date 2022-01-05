import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_state.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/logger.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  late final TaskRepository _taskRepository;
  late final TasksCubit _tasksCubit;

  AddTaskCubit(
    TasksCubit tasksCubit, {
    TaskRepository? taskRepository,
  }) : super(InitialAddTaskState()) {
    _tasksCubit = tasksCubit;
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
  }

  /// Begins or continues the construction of a new task with the given attributes
  Future<void> addTaskAttribute(CreateTaskDto newDto) async {
    final currentState = state;
    if (currentState is InitialAddTaskState ||
        currentState is TaskAdded ||
        currentState is AddTaskError) {
      // Begin the construction of a new task with the given attribute(s)
      emit(ConstructingTask(createTaskDto: newDto));
    } else if (currentState is ConstructingTask) {
      // Add the given task attributes to the currently constructed task
      ConstructingTask constructingState = currentState;
      constructingState.createTaskDto.applyChangesFrom(newDto);
      emit(constructingState);
    } else {
      // Currently busy saving a task -> Error
      emit(AddTaskError());
    }
  }

  /// Finishes the construction of a new task by storing it in the database
  Future<void> saveTask() async {
    final currentState = state;
    if (currentState is ConstructingTask) {
      emit(SavingTask());
      // Save the task, if all required attributes are given
      ConstructingTask constructingState = currentState;
      if (constructingState.createTaskDto.isReadyToStore()) {
        int newTaskId =
            await _taskRepository.createTask(constructingState.createTaskDto);
        // Reload the task list with the new entry:
        // This is triggered now rather than adding the single new task to the
        // already loaded list, because:
        // A: It would be a new DB-request anyways due to the ListReadTaskDto
        //    that is required now.
        // B: With the upcoming sorting, filtering, dynamic loading functionality,
        //    this would hardly work anyway.
        // TODO: remove this  as it is not required anymore thanks to streams and reactivity
        // await _tasksCubit.loadTasks();
        logger.d("[Task Cubit] New task was saved. Id: $newTaskId");
        emit(TaskAdded());
      } else {
        // Not all requirements given
        logger.d(
            "[Task Cubit] Save task triggered, but not every required attribute was set");
        emit(ConstructingTask(createTaskDto: currentState.createTaskDto));
      }
    } else if (currentState is InitialAddTaskState) {
      // The task has to be constructed first with 'addTaskAttribute'
      logger.d(
          "[Task Cubit] Save task triggered without adding attributes first");
      emit(AddTaskError());
    }
  }
}
