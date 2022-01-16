import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';

abstract class AlterTaskState {}

class WaitingForAlterTaskState extends AlterTaskState {}

class ConstructingNewTask extends AlterTaskState {
  CreateTaskDto createTaskDto;

  ConstructingNewTask({required this.createTaskDto});
}

class AlteringExistingTask extends AlterTaskState {
  UpdateTaskDto updateTaskDto;

  AlteringExistingTask({required this.updateTaskDto});
}
