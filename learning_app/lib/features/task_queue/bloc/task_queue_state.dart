part of 'task_queue_bloc.dart';

abstract class TaskQueueState {}

class TaskQueueInitial extends TaskQueueState {
}

class TaskQueueReady extends TaskQueueState {
  final List<TaskWithQueueStatus> tasks;

  TaskQueueReady(this.tasks);

}
