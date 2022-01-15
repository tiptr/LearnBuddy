part of 'task_queue_bloc.dart';



abstract class TaskQueueState{}

class TaskQueueInit extends TaskQueueState{}


class TaskQueueReady extends TaskQueueState{
  final List<TaskWithQueueStatus> tasks;


  TaskQueueReady({required this.tasks});

  List<TaskWithQueueStatus>? get getTasks => tasks;

}
