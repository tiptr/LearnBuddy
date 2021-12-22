part of 'time_logging_bloc.dart';


abstract class TimeLoggingState{

}


class TimeLoggingNoObjectState extends TimeLoggingState {

}

class TimeLoggingHasObjectState extends TimeLoggingState {
  final int  id;

  TimeLoggingHasObjectState(this.id);

}