import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TaskRepository {
  Future<List<ListReadTaskDto>> loadTasks();

  Stream<List<ListReadTaskDto>> watchTasks();

  /// Creates a new task and returns it with its newly generated id
  Future<int> createTask(CreateTaskDto newTask);

  Future<bool> update(int id, UpdateTaskDto updateDto);

  Future<bool> deleteById(int id);

  Future<bool> toggleDone(int taskId, bool done);
}
