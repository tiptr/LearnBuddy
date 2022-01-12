import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

class Task {
  int id;
  String title;
  DateTime? doneDateTime;
  String? description;
  Category? category;
  List<KeyWord> keywords;
  List<TimeLog> timeLogs;
  Duration? estimatedTime;
  DateTime? dueDate;
  DateTime creationDateTime;
  List<Task> children;
  List<LearnList> learnLists;
  Duration manualTimeEffortDelta;

  int get subTaskCount {
    // TODO: think about whether the count of sub-tasks should only return the
    // sub-tasks, or also the amount of sub-sub-tasks and deeper
    return children.length;
  }

  int get finishedSubTaskCount {
    // TODO: implement this!
    return children.length;
  }

  // Prefers higher definition of estimated time; I.e. if top level task has time estimate,
  // other estimates are not included.
  Duration get fullTimeEstimation {
    Duration estimatedTimeChildren = const Duration();
    for (Task task in children) {
      estimatedTimeChildren += task.fullTimeEstimation;
    }
    return estimatedTime ?? estimatedTimeChildren;
  }

  // I'm not sure if this is the right implementation of this
  Duration? get remainingTimeEstimation {
    return fullTimeEstimation - sumAllTimeLogs;
  }

  List<Task> get allTasks {
    List<Task> taskList = [this];
    for (Task task in children) {
      taskList.addAll(task.allTasks);
    }
    return taskList;
  }

  List<TimeLog> get allTimeLogs {
    List<TimeLog> timeLogsList = timeLogs;
    for (Task task in children) {
      timeLogsList.addAll(task.allTimeLogs);
    }
    return timeLogsList;
  }

  Duration get sumAllTimeLogs {
    Duration duration = const Duration();
    for (TimeLog log in allTimeLogs) {
      duration += log.duration;
    }
    return duration;
  }

  Task({
    required this.id,
    required this.title,
    this.doneDateTime,
    this.description,
    this.category,
    required this.keywords,
    required this.timeLogs,
    this.estimatedTime,
    this.dueDate,
    required this.creationDateTime,
    required this.children,
    required this.learnLists,
    required this.manualTimeEffortDelta,
  });
}
