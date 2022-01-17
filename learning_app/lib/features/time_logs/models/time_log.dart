import 'package:equatable/equatable.dart';

class TimeLog extends Equatable {
  final int id;
  final int taskId;
  final DateTime beginTime;
  final Duration duration;

  const TimeLog({
    required this.id,
    required this.taskId,
    required this.beginTime,
    required this.duration,
  });

  @override
  List<Object> get props => [id, taskId, beginTime, duration];
}
