part of 'time_logging_bloc.dart';

abstract class TimeLoggingState extends Equatable {}

// No object is registrated
class InactiveState extends TimeLoggingState {
  @override
  List<Object?> get props => [];
}

// Object is added, timer is not yet started
class InitializedState extends TimeLoggingState {
  final Stream<Task> taskStream; //This task can be shown in the UI

  InitializedState({
    required this.taskStream,
  });

  @override
  List<Object?> get props => [taskStream];
}

// Timer is active
class ActiveState extends TimeLoggingState {
  final TimeLog timeLog;
  // This is the task as it was loaded before the timer started. In the UI the
  // shown task time has to be added with the timelog.
  final Stream<Task> taskStream;

  ActiveState({
    required this.timeLog,
    required this.taskStream,
  });

  @override
  List<Object?> get props => [timeLog, taskStream];
}
