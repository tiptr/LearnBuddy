import 'package:equatable/equatable.dart';

class QueueStatus extends Equatable {
  final int queuePlacement; // null, if not queued
  final DateTime addedToQueueDateTime; // null, if not queued

  const QueueStatus(
      {required this.queuePlacement, required this.addedToQueueDateTime});

  @override
  List<Object?> get props => [
        queuePlacement,
        addedToQueueDateTime,
      ];
}
