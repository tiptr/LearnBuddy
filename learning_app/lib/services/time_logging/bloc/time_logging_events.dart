part of 'time_logging_bloc.dart';



abstract class TimeLoggingEvent{

  const TimeLoggingEvent();


}


class AddTimeLoggingObjectEvent extends TimeLoggingEvent{
  final int id;

  const AddTimeLoggingObjectEvent(this.id); 
}

class RemoveTimeLoggingObjectEvent extends TimeLoggingEvent{
  const RemoveTimeLoggingObjectEvent();
}

class AddDurationEvent extends TimeLoggingEvent {
  final Duration duration;

  const AddDurationEvent(this.duration);
}