import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';

class TasksCubit extends Cubit<TaskState> {
  late final TaskRepository _taskRepository;

  TasksCubit({TaskRepository? taskRepository}) : super(InitialTaskState()) {
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
  }

  Future<void> loadTasks() async {
    // TODO: think about removing TaskLoading() since this state is
    //  maybe not required anymore thanks to the streams
    // TODO: I guess the state will be the right place to store the currently selected filters and more
    emit(TaskLoading());
    var tasks = _taskRepository.watchFilteredSortedTasks();
    emit(TasksLoaded(selectedTasksStream: tasks));
  }

  // Toggles the done flag in a task in the cubit state
  Future<void> toggleDone(int taskId, bool done) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var success = await _taskRepository.toggleDone(taskId, done);
      if (!success) return;

      // Here, since only one flag is changed, the list does not have to be
      // reloaded:
      // Create a deep copy so the actual state isn't mutated
      // var tasks = List<ListReadTaskDto>.from(currentState.tasks);
      // int index = tasks.indexWhere((ListReadTaskDto t) => t.id == taskId);
      // tasks[index] = ListReadTaskDto(
      //   id: tasks[index].id,
      //   title: tasks[index].title,
      //   done: !tasks[index].done, // toggle
      //   categoryColor: tasks[index].categoryColor,
      //   keywords: tasks[index].keywords,
      //   remainingTimeEstimation: tasks[index].remainingTimeEstimation,
      //   dueDate: tasks[index].dueDate,
      //   subTaskCount: tasks[index].subTaskCount,
      //   finishedSubTaskCount: tasks[index].finishedSubTaskCount,
      //   isQueued: false,
      // );
      //
      // emit(TasksLoaded(tasks: tasks));
      // TODO: remove
    }
  }

  Future<void> deleteTaskById(int id) async {
    final currentState = state;

    if (currentState is TasksLoaded) {
      var success = await _taskRepository.deleteById(id);
      if (!success) return;
      // TODO: notify user? Maybe not required, since this can never fail?

      // TODO: if the task has subtasks, notify the user about this

      // TODO: remove this, because it is not needed anymore thanks to reactivity through streams and listeners
      // Refresh the list to remove the task
      // loadTasks();
    }
  }

  /// This returns the details-dto for a task
  ///
  /// The task has to be currently loaded for this, otherwise it will return null
  Future<DetailsReadTaskDto?> getDetailsDtoForTopLevelTaskId(int taskId) async {
    final currentState = state;
    if (currentState is TasksLoaded) {
      final List<TaskWithQueueStatus?> tasksWithQueueList =
          await currentState.selectedTasksStream.first;
      final TaskWithQueueStatus? selectedTaskWithQueueStatus =
          tasksWithQueueList.firstWhereOrNull(
              (taskWithQueue) => taskWithQueue?.task.id == taskId);
      // Only create a details-dto, if the task was found
      if (selectedTaskWithQueueStatus != null) {
        return DetailsReadTaskDto.fromTaskWithQueueStatus(
            selectedTaskWithQueueStatus);
      } else {
        return null;
      }
    } else {
      // tasks not yet loaded
      return null;
    }
  }

  /// This returns the details-dto for a task
  ///
  /// The task has to be currently loaded for this, otherwise it will return null
  Stream<DetailsReadTaskDto?>? getDetailsDtoForTopLevelTaskIdStream(
      int taskId) {
    final currentState = state;
    if (currentState is TasksLoaded) {
      return currentState.selectedTasksStream.map((tasksWithQueueList) {
        final TaskWithQueueStatus? selectedTaskWithQueueStatus =
            tasksWithQueueList.firstWhereOrNull(
                (taskWithQueue) => taskWithQueue.task.id == taskId);
        // Only create a details-dto, if the task was found
        if (selectedTaskWithQueueStatus != null) {
          return DetailsReadTaskDto.fromTaskWithQueueStatus(
              selectedTaskWithQueueStatus);
        } else {
          return null;
        }
      });
    } else {
      // tasks not yet loaded
      return null;
    }
  }
}
