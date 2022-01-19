import 'package:drift/drift.dart';

class TaskFilter {
  final Value<List<int>> categories;
  // Keywords and Categories are alternatives: If one matches, the task is being returned
  final Value<List<int>> keywords;
  // A task is considered done starting the day after the one it was toggled done
  final Value<bool> done;
  final Value<bool> dueToday;

  // Further information -> only used by the frontend
  final List<String> categoryNames;
  final List<String> keywordNames;

  const TaskFilter({
    this.categories = const Value.absent(),
    this.keywords = const Value.absent(),
    this.done = const Value(false), // Default: only active tasks
    this.dueToday = const Value.absent(),
    this.categoryNames = const [],
    this.keywordNames = const [],
  });

  bool isCustomFilter() {
    return categories.present ||
        keywords.present ||
        !done.present ||
        (done.present && done.value == true) ||
        dueToday.present;
  }
}
