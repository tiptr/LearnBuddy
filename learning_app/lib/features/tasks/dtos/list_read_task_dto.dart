import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

/// Contains everything about a task, that is required to display it in a list
class ListReadTaskDto extends Equatable {
  final int id;
  final String title;
  final bool done;
  final Color? categoryColor;
  final List<String> keywords;

  // This is not the same as estimatedTime of a task entity.
  // Instead, here the estimations of the subtasks are accumulated and the
  // estimations of finished subtasks are not added
  final Duration? remainingTimeEstimation; // minutes

  final DateTime? dueDate;

  final int subTaskCount;
  final int finishedSubTaskCount;

  final bool isQueued;

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
    required this.isQueued,
  });

  static ListReadTaskDto fromTaskWithQueueStatus(
      TaskWithQueueStatus taskWithQueueStatus) {
    final task = taskWithQueueStatus.task;
    return ListReadTaskDto(
      id: task.id,
      title: task.title,
      done: task.doneDateTime != null,
      categoryColor: task.category?.color,
      subTaskCount: task.subTaskCount,
      finishedSubTaskCount: task.finishedSubTaskCount,
      isQueued: taskWithQueueStatus.queueStatus != null,
      keywords: task.keywords.map((keyword) => keyword.name).toList(),
      dueDate: task.dueDate,
      remainingTimeEstimation: task.remainingTimeEstimation,
    );
  }

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
        isQueued,
      ];
}
