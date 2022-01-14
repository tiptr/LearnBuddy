part of 'task_queue_bloc.dart';


abstract class TaskQueueEvent {}



class InitQueueEvent extends TaskQueueEvent {
  final List<TaskWithQueueStatus> taskList;
  InitQueueEvent(this.taskList);
}



class UpdateQueueOrderEvent extends TaskQueueEvent {
  final List<TaskWithQueueStatus> taskList;

  UpdateQueueOrderEvent(this.taskList);

}