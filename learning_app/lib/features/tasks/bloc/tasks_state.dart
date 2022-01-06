import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskState {}

class TaskLoading extends TaskState {}

// TODO: refactor TaskState to hold the filters rather than the stream
// TaskLoading also is not required anymore, since the stream itself has a state
// which will be used by the UI (for loading indicator)
// ignore: must_be_immutable
class TasksLoaded extends TaskState {
  Stream<List<TaskWithQueueStatus>> selectedTasksStream;
  late Stream<List<ListReadTaskDto>> selectedListViewTasksStream;

  TasksLoaded({required this.selectedTasksStream}) {
    selectedListViewTasksStream = selectedTasksStream.map((tasksList) {
      return tasksList.map((task) => ListReadTaskDto.fromTask(task)).toList();
    });
  }

  @override
  List<Object> get props => [selectedTasksStream];
}
