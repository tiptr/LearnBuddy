import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final bool done;
  final String? description;
  // final Category category;
  final int? estimatedTime; // minutes

  final DateTime dueDate;
  // dueDate is not optional, because there is no good way to integrate
  // tasks without one into the sorted list of the UI.
  // Instead, 'Today' is the predefined due_date
  // Currently, the time part of this DateTime is not really used, but this
  // could change later

  final DateTime creationDateTime;

  final Task? parentTask;

  final int? manualTimeEffortDelta;

  const Task({
    required this.id,
    required this.title,
    required this.done,
    this.description,
    // required this.category,
    this.estimatedTime,
    required this.dueDate,
    required this.creationDateTime,
    this.parentTask,
    this.manualTimeEffortDelta,
  });

  @override
  String toString() {
    return "TODO: $id - $title - $done";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object> get props => [id, title, done];
}
