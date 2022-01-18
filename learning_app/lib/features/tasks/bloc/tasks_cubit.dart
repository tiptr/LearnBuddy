import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
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

  /// This returns the details-dto for a task (subtask or top-level)
  ///
  /// The topLevelParentId has to be provided to efficiently find the task
  Stream<DetailsReadTaskDto?>? getDetailsDtoStreamById(
      int taskId, int topLevelParentId) {
    final topLevelTaskStream =
        _taskRepository.watchTopLevelTaskById(id: topLevelParentId);

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
}
