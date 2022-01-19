part of 'time_logging_bloc.dart';

abstract class TimeLoggingEvent {
  const TimeLoggingEvent();
}

class AddTimeLoggingObjectEvent extends TimeLoggingEvent {
  final int id;
  final int parentId; // Top level tasks has id == parentId

  const AddTimeLoggingObjectEvent(this.id, this.parentId);
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

class TaskChangedEvent extends TimeLoggingEvent {
  final TaskWithQueueStatus? parentTask;
  final Task? task;
  const TaskChangedEvent({
    this.task,
    this.parentTask,
  });
}

class StopTimeLoggingEvent extends TimeLoggingEvent {}
