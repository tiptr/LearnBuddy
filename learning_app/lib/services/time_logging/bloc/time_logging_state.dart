part of 'time_logging_bloc.dart';

abstract class TimeLoggingState extends Equatable {}

// No object is registrated
class InactiveState extends TimeLoggingState {
  @override
  List<Object?> get props => [];
}

// Object is added, timer is not yet started
class InitializedState extends TimeLoggingState {
  final Task task; //This task can be shown in the UI

  InitializedState({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

// Timer is active
class ActiveState extends TimeLoggingState {
  final TimeLog timeLog;
  // This is the task as it was loaded before the timer started. In the UI the
  // shown task time has to be added with the timelog.
  final Task task;

  ActiveState({
    required this.timeLog,
    required this.task,
  });

  @override
  List<Object?> get props => [timeLog];
}
