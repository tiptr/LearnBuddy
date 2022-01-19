import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';

class TasksCubit extends Cubit<TaskState> {
  late final TaskRepository _taskRepository;
  late final QueueRepository _queueRepository;

  TasksCubit({TaskRepository? taskRepository, QueueRepository? queueRepository})
      : super(InitialTaskState()) {
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
    _queueRepository = queueRepository ?? getIt<QueueRepository>();
  }

  Future<void> loadTasksWithoutFilter() async {
    var tasks = _taskRepository.watchFilteredSortedTasks();
    emit(TasksLoaded(selectedTasksStream: tasks));
  }

  Future<void> loadFilteredTasks(TaskFilter taskFilter) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var tasks =
          _taskRepository.watchFilteredSortedTasks(taskFilter: taskFilter);
      emit(TasksLoaded(
        selectedTasksStream: tasks,
        taskFilter: taskFilter,
      ));
    }
  }

  bool isFilterActive() {
    final currentState = state;

    if (currentState is TasksLoaded) {
      final filter = currentState.taskFilter;
      if (filter == null) {
        return false;
      } else {
        return filter.isCustomFilter();
      }
    }
    return false;
  }

  /// Toggles the done flag in a task in the cubit state
  Future<void> toggleDone(int taskId, bool done) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      await _taskRepository.toggleDone(taskId, done);
    }
  }

  /// Toggles the queued status in a task in the cubit state
  Future<void> toggleQueued({required int taskId, required bool queued}) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      await _queueRepository.toggleQueued(taskId: taskId, queued: queued);
    }
  }

  /// Deletes the task including subtasks and all related entities
  Future<void> deleteTaskById(int id) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      await _taskRepository.deleteById(id);
    }
  }

  /// This returns the details-dto for a task (subtask or top-level)
  ///
  /// The topLevelParentId has to be provided to efficiently find the task
  Stream<DetailsReadTaskDto?>? getDetailsDtoStreamById(
      int taskId, int topLevelParentId) {
    final topLevelTaskStream =
        _taskRepository.watchTaskById(id: topLevelParentId);

    return topLevelTaskStream.map((topLevel) {
      // Only create a details-dto, if the task was found
      if (topLevel != null) {
        return DetailsReadTaskDto.fromTaskWithQueueStatus(
            topLevelTaskWithQueueStatus: topLevel, targetId: taskId);
      } else {
        return null;
      }
    });
  }

  /// This returns the list-dtos for all due tasks
  Stream<List<ListReadTaskDto>>? getDetailsDtoStreamForDashboard() {
    final tasksStream = _taskRepository.watchFilteredSortedTasks(
      taskFilter: const TaskFilter(
        dueToday: Value(true),
      ),
    );

    return tasksStream.map((tasksList) {
      return tasksList
          .map((task) => ListReadTaskDto.fromTaskWithQueueStatus(task))
          .toList();
    });
  }
}
