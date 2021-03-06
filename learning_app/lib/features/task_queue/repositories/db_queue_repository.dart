import 'package:injectable/injectable.dart';
import 'package:learning_app/features/task_queue/persistence/task_queue_elements_dao.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/util/injection.dart';

@Injectable(as: QueueRepository)
class DbQueueRepository implements QueueRepository {
  final TaskQueueElementsDao dao = getIt<TaskQueueElementsDao>();

  @override
  Future<int> writeQueueOrder(List<TaskWithQueueStatus> taskList) async {
    // Do the complete update in a transaction, so that the streams will only
    // update once, after the whole update is ready

    // Important: whenever using transactions, every (!) query / update / insert
    //            inside, has to be awaited -> data loss possible otherwise!
    int count = await dao.transaction(() async {
      int count = 0;

      for (int i = 0; i < taskList.length; i++) {
        count += await dao.updateQueuePosition(taskList[i].task.id, i);
      }
      return count;
    });
    return count;
  }

  @override
  Future<bool> toggleQueued({required int taskId, required bool queued}) async {
    if (queued) {
      // Add to queue
      await dao.addElementToQueueByTaskId(taskId);
      return true;
    } else {
      // Remove from queue
      final affected = await dao.deleteQueueElementByTaskId(taskId);
      return affected > 0;
    }
  }
}
