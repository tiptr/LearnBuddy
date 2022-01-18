import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

/// Contains everything about a task, that is required to display it in a list
class ListReadTaskDto extends Equatable {
  final int id;
  final int? topLevelParentId;

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
    this.topLevelParentId,
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
      topLevelParentId: task.id, // is top-level of its own
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

  static ListReadTaskDto fromDetailsReadTasksDto(
      DetailsReadTaskDto detailsDto) {
    return ListReadTaskDto(
      id: detailsDto.id,
      topLevelParentId: detailsDto.topLevelParentId,
      title: detailsDto.title,
      done: detailsDto.done,
      categoryColor: detailsDto.category?.color,
      subTaskCount: detailsDto.subTaskCount,
      finishedSubTaskCount: detailsDto.finishedSubTaskCount,
      isQueued: detailsDto.isQueued,
      keywords:
          detailsDto.keywords.map((keywordDto) => keywordDto.name).toList(),
      dueDate: detailsDto.dueDate,
      remainingTimeEstimation: detailsDto.remainingTimeEstimation,
    );
  }

  @override
  List<Object?> get props => [
        id,
        topLevelParentId,
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
