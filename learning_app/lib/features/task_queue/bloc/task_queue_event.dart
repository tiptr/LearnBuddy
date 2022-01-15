part of 'task_queue_bloc.dart';

abstract class TaskQueueEvent {}

class UpdateQueueEvent extends TaskQueueEvent {
  final List<TaskWithQueueStatus> taskList;
  UpdateQueueEvent(this.taskList);
}

class UpdateQueueOrderEvent extends TaskQueueEvent {
  final List<TaskWithQueueStatus> taskList;
  UpdateQueueOrderEvent(this.taskList);
}

class InitQueueEvent extends TaskQueueEvent {
  InitQueueEvent();
}
