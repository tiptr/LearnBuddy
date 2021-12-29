import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TaskRepository {
  Future<List<Task>> loadTasks() {
    return Future.value([const Task(id: 17, title: 'asdfasd', done: false)]);
  }

  Future<Task> createTask(CreateTaskDto taskDto);

  Future<bool> update(int id, UpdateTaskDto updateDto);

  Future<bool> deleteById(int id);
}
