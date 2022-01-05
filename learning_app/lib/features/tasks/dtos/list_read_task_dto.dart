import 'dart:ui';
import 'package:equatable/equatable.dart';

/// Contains everything about a task, that is required to display it in a list
///
/// Includes the ID for actions on it, although it is not being displayed
class ListReadTaskDto extends Equatable {
  final int id;
  final String title;
  final bool done;
  final Color categoryColor;
  final List<String> keywords;

  // This is not the same as estimatedTime of a task entity.
  // Instead, here the estimations of the subtasks are accumulated and the
  // estimations of finished subtasks are not added
  final Duration? remainingTimeEstimation; // minutes

  // dueDate is not optional, because there is no good way to integrate
  // tasks without one into the sorted list of the UI.
  // Instead, 'Today' is the predefined due_date
  // Currently, the time part of this DateTime is not really used, but this
  // could change later
  final DateTime? dueDate;

  final int subTaskCount;
  final int finishedSubTaskCount;

  const ListReadTaskDto({
    required this.id,
    required this.title,
    required this.done,
    required this.categoryColor,
    required this.keywords,
    this.remainingTimeEstimation,
    this.dueDate,
    required this.subTaskCount,
    required this.finishedSubTaskCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        done,
        categoryColor,
        keywords,
        remainingTimeEstimation,
        dueDate,
        subTaskCount,
        finishedSubTaskCount,
      ];
}
