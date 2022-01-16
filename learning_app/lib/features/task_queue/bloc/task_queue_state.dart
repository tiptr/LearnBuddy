part of 'task_queue_bloc.dart';

abstract class TaskQueueState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskQueueInit extends TaskQueueState {}

class TaskQueueReady extends TaskQueueState {
  final List<TaskWithQueueStatus> tasks;
  final int? selectedTask;

  TaskQueueReady({required this.tasks, this.selectedTask});

  List<TaskWithQueueStatus>? get getTasks => tasks;

  @override
  List<Object?> get props => [tasks, selectedTask];
}
