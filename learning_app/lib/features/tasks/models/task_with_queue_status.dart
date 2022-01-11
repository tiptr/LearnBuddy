import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/queue_status.dart';
import 'package:learning_app/features/tasks/models/task.dart';

class TaskWithQueueStatus extends Equatable {
  final Task task;
  final QueueStatus? queueStatus; // null, if not queued

  const TaskWithQueueStatus({
    required this.task,
    this.queueStatus,
  });

  @override
  List<Object?> get props => [
        task,
        queueStatus,
      ];
}
