import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/learning_aids/models/learn_list.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final bool done;
  final String? description;

  final Category? category;

  final List<KeyWord> keywords;

  final List<TimeLog> timeLogs;

  final Duration? estimatedTime; // minutes

  // dueDate is not optional, because there is no good way to integrate
  // tasks without one into the sorted list of the UI.
  // Instead, 'Today' is the predefined due_date
  // Currently, the time part of this DateTime is not really used, but this
  // could change later
  final DateTime? dueDate;

  final DateTime creationDateTime;

  final List<Task> children;

  final List<LearnList> learnLists;

  final Duration? manualTimeEffortDelta;

  const Task({
    required this.id,
    required this.title,
    required this.done,
    this.description,
    this.category,
    required this.keywords,
    required this.timeLogs,
    this.estimatedTime,
    this.dueDate,
    required this.creationDateTime,
    required this.children,
    required this.learnLists,
    this.manualTimeEffortDelta,
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
        children,
        manualTimeEffortDelta,
      ];
}
