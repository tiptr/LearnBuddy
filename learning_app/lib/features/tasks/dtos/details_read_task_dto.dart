import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

/// Contains everything about a task, that is required to display its details
/// view and update the task
class DetailsReadTaskDto {
  final int id;
  final int? topLevelParentId;
  final List<String> ancestorTitles; // lowest index -> top-level

  final String title;
  final bool done;
  final String? description;
  final ReadCategoryDto? category;
  final List<ReadKeyWordDto> keywords;
  final Duration? estimatedTime;
  final DateTime? dueDate;
  final DateTime creationDateTime;
  final bool isQueued;
  final int subTaskCount;
  final int finishedSubTaskCount;
  // This is not the same as estimatedTime of a task entity.
  // Instead, here the estimations of the subtasks are accumulated and the
  // estimations of finished subtasks are not added
  final Duration? remainingTimeEstimation; // minutes
  final Duration timeLogSum;

  final List<DetailsReadTaskDto> children;

  // TODO: learnlists
  // final List<ReadLearnListDto> learnLists;

  // TODO: time logs (including the manual time effort delta
  // final Duration manualTimeEffortDelta;
  // final Duration sumOfTimeLogsForThisTask;
  // final Duration sumOfTimeLogsForThisTaskWithChildren;

  const DetailsReadTaskDto({
    required this.id,
    required this.topLevelParentId,
    required this.ancestorTitles,
    required this.title,
    required this.done,
    this.description,
    this.category,
    required this.keywords,
    this.estimatedTime,
    this.dueDate,
    required this.creationDateTime,
    required this.isQueued,
    required this.subTaskCount,
    required this.finishedSubTaskCount,
    this.remainingTimeEstimation,
    required this.children,
    this.timeLogSum = Duration.zero,
  });

  /// Creates a details dto from the model. Optionally can provide the details
  /// DTO for a specific subtask (of this model), if a targetId is provided
  static DetailsReadTaskDto? fromTaskWithQueueStatus(
      {required TaskWithQueueStatus topLevelTaskWithQueueStatus,
      int? targetId}) {
    final task = topLevelTaskWithQueueStatus.task;

    DetailsReadTaskDto topLevelDetailsDto = _buildFromTaskWithQueueStatus(
      task: task,
      ancestorTitles: [],
      topLevelParentId: task.id,
      isQueued: topLevelTaskWithQueueStatus.queueStatus != null,
    );
    // If not specified, return the top level task
    final actualTargetId = targetId ?? task.id;
    // Find the targeted subtask recursively:
    return _findSubTaskWithIdRecursive(topLevelDetailsDto, actualTargetId);
  }

  /// Used to recursively find a subtask with a specific ID
  static DetailsReadTaskDto? _findSubTaskWithIdRecursive(
      DetailsReadTaskDto dto, int targetId) {
    if (dto.id == targetId) {
      return dto;
    } else {
      for (DetailsReadTaskDto child in dto.children) {
        final result = _findSubTaskWithIdRecursive(child, targetId);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  /// Used to build a details dto for a top level task
  static DetailsReadTaskDto _buildFromTaskWithQueueStatus({
    required Task task,
    required List<String> ancestorTitles,
    required int? topLevelParentId,
    required bool isQueued,
  }) {
    // Deep copy!
    // But all children in the same level can have the same individual list
    List<String> ancestorTitlesIncludingThis =
        List<String>.from(ancestorTitles);
    ancestorTitlesIncludingThis.add(task.title);

    return DetailsReadTaskDto(
      id: task.id,
      topLevelParentId: topLevelParentId,
      ancestorTitles: ancestorTitles,
      title: task.title,
      done: task.doneDateTime != null,
      description: task.description,
      category: ReadCategoryDto.fromCategory(task.category),
      keywords: task.keywords
          .map((keyWord) => ReadKeyWordDto.fromKeyWord(keyWord))
          .toList(),
      estimatedTime: task.estimatedTime,
      dueDate: task.dueDate,
      creationDateTime: task.creationDateTime,
      isQueued: isQueued,
      subTaskCount: task.subTaskCount,
      finishedSubTaskCount: task.finishedSubTaskCount,
      remainingTimeEstimation: task.remainingTimeEstimation,
      timeLogSum: task.sumAllTimeLogs,
      children: task.children
          .map((subTask) => DetailsReadTaskDto._buildFromTaskWithQueueStatus(
                task: subTask,
                ancestorTitles: ancestorTitlesIncludingThis,
                topLevelParentId: topLevelParentId,
                isQueued: false, // Subtasks can't be individually queued
              ))
          .toList(),
    );
  }
}
