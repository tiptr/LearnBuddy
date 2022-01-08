import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/task.dart';

class TaskWithQueueStatus extends Equatable {
  final Task task;
  final bool isQueued;

  const TaskWithQueueStatus({
    required this.task,
    required this.isQueued,
  });

  @override
  List<Object?> get props => [
        task,
        isQueued,
      ];
}
