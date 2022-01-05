import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final bool done;
  final String? description;

  final Category? category;

  // TODO: keywords?

  final Duration? estimatedTime; // minutes

  final DateTime? dueDate;
  // dueDate is not optional, because there is no good way to integrate
  // tasks without one into the sorted list of the UI.
  // Instead, 'Today' is the predefined due_date
  // Currently, the time part of this DateTime is not really used, but this
  // could change later

  final DateTime creationDateTime;

  final Task? parentTask;

  final Duration manualTimeEffortDelta;

  const Task({
    required this.id,
    required this.title,
    required this.done,
    this.description,
    this.category,
    this.estimatedTime,
    this.dueDate,
    required this.creationDateTime,
    this.parentTask,
    required this.manualTimeEffortDelta,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        done,
        description,
        estimatedTime,
        dueDate,
        creationDateTime,
        parentTask,
        manualTimeEffortDelta,
      ];
}
