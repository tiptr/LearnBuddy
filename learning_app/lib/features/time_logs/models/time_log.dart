import 'package:equatable/equatable.dart';

class TimeLog extends Equatable {
  final int id;
  final DateTime begin;
  final Duration duration;

  const TimeLog({
    required this.id,
    required this.begin,
    required this.duration,
  });

  @override
  List<Object> get props => [id, begin, duration];
}
