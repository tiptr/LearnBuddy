import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

/// Contains everything about a task, that is required to display its details
/// view and update the task
class DetailsReadTaskDto {
  final int id;
  final String title;
  final bool done;
  final String? description;
  final ReadCategoryDto? category;
  final List<ReadKeyWordDto> keywords;
  final Duration? estimatedTime;
  final DateTime? dueDate;
  final DateTime creationDateTime;
  final bool isQueued;

  final List<DetailsReadTaskDto> children;

  // TODO: learnlists
  // final List<ReadLearnListDto> learnLists;

  // TODO: time logs (including the manual time effort delta
  // final Duration manualTimeEffortDelta;
  // final Duration sumOfTimeLogsForThisTask;
  // final Duration sumOfTimeLogsForThisTaskWithChildren;

  const DetailsReadTaskDto({
    required this.id,
    required this.title,
    required this.done,
    this.description,
    this.category,
    required this.keywords,
    this.estimatedTime,
    this.dueDate,
    required this.creationDateTime,
    required this.isQueued,
    required this.children,
  });

  static DetailsReadTaskDto fromTaskWithQueueStatus(
      TaskWithQueueStatus taskWithQueueStatus) {
    final task = taskWithQueueStatus.task;

    return DetailsReadTaskDto(
      id: task.id,
      title: task.title,
      done: task.doneDateTime != null,
      category: ReadCategoryDto.fromCategory(task.category),
      keywords: task.keywords
          .map((keyWord) => ReadKeyWordDto.fromKeyWord(keyWord))
          .toList(),
      estimatedTime: task.estimatedTime,
      dueDate: task.dueDate,
      creationDateTime: task.creationDateTime,
      isQueued: taskWithQueueStatus.queueStatus != null,
      children: task.children
          .map((task) => DetailsReadTaskDto.fromTaskWithQueueStatus(
              TaskWithQueueStatus(task: task)))
          .toList(),
    );
  }
}
