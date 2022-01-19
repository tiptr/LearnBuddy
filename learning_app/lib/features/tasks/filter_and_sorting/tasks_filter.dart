import 'package:drift/drift.dart';

class TaskFilter {
  final Value<List<int>> categories;
  // Keywords and Categories are alternatives: If one matches, the task is being returned
  final Value<List<int>> keywords;
  // A task is considered done starting the day after the one it was toggled done
  final Value<bool> done;
  final Value<bool> overDue;

  const TaskFilter({
    this.categories = const Value.absent(),
    this.keywords = const Value.absent(),
    this.done = const Value(false), // Default: only active tasks
    this.overDue = const Value.absent(),
  });
}
