import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TaskRepository {
  Future<List<Task>> loadTasks();

  /// Creates a new task and returns it with its newly generated id
  Future<Task> createTask(CreateTaskDto newTask);

  Future<bool> update(int id, UpdateTaskDto updateDto);

  Future<bool> deleteById(int id);

  Future<bool> toggleDone(int id);
}
