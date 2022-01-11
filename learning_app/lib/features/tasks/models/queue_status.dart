import 'package:equatable/equatable.dart';

class QueueStatus extends Equatable {
  final int queuePlacement;
  final DateTime addedToQueueDateTime;

  const QueueStatus(
      {required this.queuePlacement, required this.addedToQueueDateTime});

  @override
  List<Object?> get props => [
        queuePlacement,
        addedToQueueDateTime,
      ];
}
