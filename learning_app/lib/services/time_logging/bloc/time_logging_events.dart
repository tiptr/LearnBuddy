part of 'time_logging_bloc.dart';

abstract class TimeLoggingEvent {
  const TimeLoggingEvent();
}

class AddTimeLoggingObjectEvent extends TimeLoggingEvent {
  final int id;

  const AddTimeLoggingObjectEvent(this.id);
}

class RemoveTimeLoggingObjectEvent extends TimeLoggingEvent {
  const RemoveTimeLoggingObjectEvent();
}

class StartTimeLoggingEvent extends TimeLoggingEvent {
  final DateTime beginTime;

  StartTimeLoggingEvent({
    required this.beginTime,
  });
}

class TimeNoticeEvent extends TimeLoggingEvent {
  final Duration duration;

  const TimeNoticeEvent({
    required this.duration,
  });
}
