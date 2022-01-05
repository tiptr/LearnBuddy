import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskState {}

class TaskLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<ListReadTaskDto> tasks;

  TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
