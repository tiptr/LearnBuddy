import 'package:learning_app/features/tasks/models/task.dart';

abstract class TaskState {}

class InitialTaskState extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded({required this.tasks});
}
