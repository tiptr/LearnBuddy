part of 'task_queue_bloc.dart';



class TaskQueueState{
  final List<TaskWithQueueStatus>? tasks;

  TaskQueueState({this.tasks});

  List<TaskWithQueueStatus>? get getTasks => tasks;

}
