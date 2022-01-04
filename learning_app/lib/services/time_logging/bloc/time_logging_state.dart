part of 'time_logging_bloc.dart';


abstract class TimeLoggingState extends Equatable{
  

}

// No object is registrated
class InactiveState extends TimeLoggingState {
  @override
  List<Object?> get props => [];
}

// Object is added, timer is not yet started
class InitializedState extends TimeLoggingState {
  final int  id;
  
  InitializedState({
    required this.id,
  });

  @override
  List<Object?> get props => [id];

}

// Timer is active
class ActiveState extends TimeLoggingState {
  final TimeLog timeLog;


  ActiveState({
    required this.timeLog,
  });

  @override
  List<Object?> get props => [timeLog];
}