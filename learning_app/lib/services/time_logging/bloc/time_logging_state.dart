part of 'time_logging_bloc.dart';


abstract class TimeLoggingState extends Equatable{
  

}


class TimeLoggingNoObjectState extends TimeLoggingState {
  @override
  List<Object?> get props => [];
  
  

}

class TimeLoggingHasObjectState extends TimeLoggingState {
  final int  id;

  TimeLoggingHasObjectState(this.id);

  @override
  List<Object?> get props => [id];

}