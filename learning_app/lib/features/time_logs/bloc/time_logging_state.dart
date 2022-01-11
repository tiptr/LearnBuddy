part of 'time_logging_bloc.dart';

abstract class TimeLoggingState extends Equatable {}

// No object is registrated
class InactiveState extends TimeLoggingState {
  @override
  List<Object?> get props => [];
}

// Object is added, timer is not yet started
class InitializedState extends TimeLoggingState {
  final TaskWithQueueStatus parentTask; //This task can be shown in the UI
  final Task task;

  InitializedState({
    required this.parentTask,
    required this.task,
  });

  @override
  List<Object?> get props => [parentTask, task];
}

// Timer is active
class ActiveState extends TimeLoggingState {
  final TimeLog timeLog;
  final TaskWithQueueStatus parentTask;
  final Task task;

  ActiveState({
    required this.timeLog,
    required this.parentTask,
    required this.task,
  });

  @override
  List<Object?> get props => [timeLog, parentTask, task];
}
