import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';

abstract class AddTaskState {}

class InitialAddTaskState extends AddTaskState {}

class AddTaskError extends AddTaskState {}

class TaskAdded extends AddTaskState {}

class ConstructingTask extends AddTaskState {
  CreateTaskDto createTaskDto;

  ConstructingTask({required this.createTaskDto});
}

class SavingTask extends AddTaskState {}
