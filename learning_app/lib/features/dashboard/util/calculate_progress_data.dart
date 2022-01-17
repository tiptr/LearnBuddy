import 'dart:math';

import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';

class ProgressData {
  final int totalTaskCount;
  final int doneTaskCount;
  final bool hasMore;
  final int moreCount;
  final List<ListReadTaskDto> upcomingTasks;
  final Duration? remainingDuration;

  const ProgressData({
    required this.doneTaskCount,
    required this.totalTaskCount,
    required this.hasMore,
    required this.moreCount,
    required this.upcomingTasks,
    required this.remainingDuration,
  });
}

ProgressData calculateProgressData(
  List<ListReadTaskDto> tasks,
  int displayCount,
) {
  final dueTasks = tasks.where((task) {
    // Only consider tasks with a due date
    return task.dueDate != null &&
        // And only those that have a due date today or earlier
        task.dueDate.compareDayOnly(DateTime.now()) <= 0;
  }).toList();

  // Sort the task so the next due dates come first
  dueTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

  // How many tasks are display in the dashboard

  final upcomingTasks = dueTasks.where((task) => !task.done);

  final hasMore = upcomingTasks.length > displayCount;
  final amountOfFurtherDueTasks = max(upcomingTasks.length - displayCount, 0);

  final upcomingToDisplay = upcomingTasks.take(displayCount);

  // Calculate remaining duration
  var durations = upcomingToDisplay
      .take(displayCount)
      .map((t) => t.remainingTimeEstimation)
      .where((d) => d != null)
      .toList();

  final remainingDuration =
      // The duration list is filtered to not equal null, so this null safety
      // can be ignored here.
      durations.isEmpty ? null : durations.reduce((acc, curr) => acc! + curr!);

  final doneTasksCount = dueTasks
      .where(
        (task) =>
            task.done &&
            task.doneDateTime != null &&
            task.doneDateTime.compareDayOnly(DateTime.now()) == 0,
      )
      .length;

  return ProgressData(
    doneTaskCount: doneTasksCount,
    totalTaskCount: dueTasks.length,
    hasMore: hasMore,
    moreCount: amountOfFurtherDueTasks,
    upcomingTasks: upcomingToDisplay.toList(),
    remainingDuration: remainingDuration,
  );
}
