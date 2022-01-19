import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskState {}

// ignore: must_be_immutable
class TasksLoaded extends TaskState {
  Stream<List<TaskWithQueueStatus>> selectedTasksStream;
  late Stream<List<ListReadTaskDto>> selectedListViewTasksStream;

  TaskFilter taskFilter;

  TasksLoaded({
    required this.selectedTasksStream,
    this.taskFilter = const TaskFilter(),
  }) {
    selectedListViewTasksStream = selectedTasksStream.map((tasksList) {
      return tasksList
          .map((task) => ListReadTaskDto.fromTaskWithQueueStatus(task))
          .toList();
    });
  }

  @override
  List<Object> get props => [selectedTasksStream, taskFilter];
}

