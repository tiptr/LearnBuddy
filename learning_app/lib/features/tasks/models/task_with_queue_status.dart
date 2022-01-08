import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/task.dart';

class TaskWithQueueStatus extends Equatable {
  final Task task;
  final int? queuePlacement;  // null, if not queued

  const TaskWithQueueStatus({
    required this.task,
    this.queuePlacement,
  });

  @override
  List<Object?> get props => [
        task,
        queuePlacement,
      ];
}
