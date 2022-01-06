import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/task.dart';

class TaskQueue extends Equatable {
  final Task task;
  final DateTime addedToQueueDateTime;
  final int orderPlacement;

  const TaskQueue(
      {required this.task,
      required this.addedToQueueDateTime,
      required this.orderPlacement});

  @override
  List<Object> get props => [task, addedToQueueDateTime, orderPlacement];
}
