import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/logger.dart';
import 'package:logger/logger.dart';

class AlterTaskCubit extends Cubit<AlterTaskState> {
  late final TaskRepository _taskRepository;

  AlterTaskCubit({
    TaskRepository? taskRepository,
  }) : super(WaitingForAlterTaskState()) {
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
  }

  /// Begins the construction of a new task.
  ///
  /// This changes to the construction state. If the given parent ID is null,
  /// a top-level task will be created.
  void startNewTaskConstruction(int? parentTaskId) {
    final currentState = state;
    if (currentState is WaitingForAlterTaskState) {
      emit(ConstructingNewTask(
        createTaskDto: CreateTaskDto(parentId: parentTaskId),
      ));
    }

    // TODO: handle other states
  }

  /// Begins the alternation of an existing task.
  ///
  /// This changes to the construction state. If the given parent ID is null,
  /// a top-level task will be created.
  void startAlteringExistingTask(int taskId) {
    final currentState = state;
    if (currentState is WaitingForAlterTaskState) {
      emit(AlteringExistingTask(
        updateTaskDto: UpdateTaskDto(id: taskId),
      ));
    }

    // TODO: handle other states
  }

  /// To be called while in 'ConstructingNewTask' or 'AlteringExistingTask' state.
  ///
  /// This will update the present values provided in 'newDto' in the current
  /// construction-dto.
  /// Writing to the database only happens centrally, when 'saveTask()' is
  /// triggered.
  void alterTaskAttribute(TaskManipulationDto newDto) {
    final currentState = state;

    if (currentState is ConstructingNewTask) {
      // Add the given task attributes to the currently constructed task
      ConstructingNewTask constructingState = currentState;
      constructingState.createTaskDto.applyChangesFrom(newDto);
      emit(constructingState);
    } else if (currentState is AlteringExistingTask) {
      // Add the given task attributes to the currently constructed task
      AlteringExistingTask constructingState = currentState;
      constructingState.updateTaskDto.applyChangesFrom(newDto);
      emit(constructingState);
    } else {
      log('Task attribute altered when not in a construction state!',
          level: Level.error.index);
    }
  }

  /// Returns whether the task is ready to be saved
  bool validateTaskConstruction() {
    final currentState = state;
    if (currentState is ConstructingNewTask) {
      ConstructingNewTask constructingState = currentState;
      return constructingState.createTaskDto.isReadyToStore;
    } else if (currentState is AlteringExistingTask) {
      AlteringExistingTask constructingState = currentState;

      return constructingState.updateTaskDto.isReadyToStore;
    } else {
      logger.d(
          'Task construction validation triggered, but not in a construction state');
      return false;
    }
  }

  /// Returns a string that explains, which fields are still missing for
  /// the validation to succeed
  String? getMissingFieldsDescription() {
    final currentState = state;
    if (currentState is ConstructingNewTask) {
      ConstructingNewTask constructingState = currentState;
      return constructingState.createTaskDto.missingFieldsDescription;
    } else if (currentState is AlteringExistingTask) {
      AlteringExistingTask constructingState = currentState;

      return constructingState.updateTaskDto.missingFieldsDescription;
    } else {
      logger.d(
          'Task construction validation triggered, but not in a construction state');
      return null;
    }
  }

  /// Finishes the construction of a new task or the update of an existing one
  /// by storing it in the database
  Future<int?> saveTask() async {
    final currentState = state;
    if (currentState is ConstructingNewTask) {
      // Save the task, if all required attributes are given
      ConstructingNewTask constructingState = currentState;
      if (constructingState.createTaskDto.isReadyToStore) {
        int newTaskId =
            await _taskRepository.createTask(constructingState.createTaskDto);
        logger.d("[Task Cubit] New task was saved. Id: $newTaskId");
        emit(WaitingForAlterTaskState());
        return newTaskId;
      } else {
        // Not all requirements given
        logger.d(
            "[Task Cubit] Save task triggered, but not every required attribute was set");
        emit(ConstructingNewTask(createTaskDto: currentState.createTaskDto));
        return null;
      }
    } else if (currentState is AlteringExistingTask) {
      // Update a task
      AlteringExistingTask constructingState = currentState;
      if (constructingState.updateTaskDto.containsUpdates()) {
        bool success =
            await _taskRepository.update(constructingState.updateTaskDto);
        logger.d(
            "[Task Cubit] Task was updated. Id: ${constructingState.updateTaskDto.id}, Success: $success");
        emit(WaitingForAlterTaskState());
        return constructingState.updateTaskDto.id;
      } else {
        // No updates made -> nothing to change
        emit(WaitingForAlterTaskState());
        return null;
      }
    } else {
      // The task has to be constructed first with 'addTaskAttribute'
      logger.d(
          "[Task Cubit] Save task triggered without being in a constructing state.");
      return null;
    }
  }

  /// Directly creates a new subTask with the given title as child of the task
  /// currently being altered
  ///
  /// Only works out of a existing task, so the state has to be 'AlteringExistingTask'
  Future<bool> createNewSubTask(String title) async {
    final currentState = state;
    if (currentState is AlteringExistingTask) {
      AlteringExistingTask constructingState = currentState;
      if (title == '') {
        // A title has to be provided first
        return false;
      }

      int newSubTaskId =
        await _taskRepository.createTask(CreateTaskDto(
            parentId: constructingState.updateTaskDto.id,
            title: Value(title),
            // Adopt the category from the parent
            categoryId: constructingState.updateTaskDto.categoryId,
        ));

      logger.d("[Task Cubit] New subtask was saved. Id: $newSubTaskId");

      return true;
    } else {
      logger.d(
          "[Task Alter Cubit] Create subtask triggered, but not in AlteringExistingTask' state.");
      return false;
    }
  }
}
