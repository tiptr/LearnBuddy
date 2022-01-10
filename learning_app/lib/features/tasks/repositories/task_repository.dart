import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TaskRepository {
  Stream<List<TaskWithQueueStatus>> watchFilteredSortedTasks({
    TaskFilter taskFilter,
    TaskOrder taskOrder,
  });

  Stream<List<TaskWithQueueStatus>> watchQueuedTasks();

  Stream<TaskWithQueueStatus?> watchQueuedTaskWithId({required int id});

  Future<int> createTask(CreateTaskDto newTask);

  Future<bool> update(int id, UpdateTaskDto updateDto);

  Future<bool> deleteById(int id);

  Future<bool> toggleDone(int taskId, bool done);
}
