import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';

abstract class QueueRepository {
  //Takes the ordered List and ignores the queue status -> will overwrite this
  Future<void> writeQueueOrder(List<TaskWithQueueStatus> taskList);

  Future<bool> toggleQueued({required int taskId, required bool queued});
}
