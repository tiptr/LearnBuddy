import 'package:learning_app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
