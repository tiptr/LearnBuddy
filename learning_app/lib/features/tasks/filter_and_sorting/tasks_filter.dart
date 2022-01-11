import 'package:drift/drift.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';

class TaskFilter {
  final Value<Category?> category;
  // Keywords are alternatives: If one matches, the task is being returned
  final Value<List<KeyWord>> keywords;
  // A task is considered done starting the day after the one it was toggled done
  final Value<bool> done;
  final Value<bool> overDue;


  const TaskFilter({
    this.category = const Value.absent(),
    this.keywords = const Value.absent(),
    this.done = const Value(false), // Default: only active tasks
    this.overDue = const Value.absent(),
  });
}
