import 'package:injectable/injectable.dart';
import 'package:learning_app/features/task_queue/persistence/queue_dao.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/util/injection.dart';

@Injectable(as: QueueRepository)
class DbQueueRepository implements QueueRepository {

  final QueueDao dao = getIt<QueueDao>();

  @override
  Future<int> writeQueueOrder(List<TaskWithQueueStatus> taskList) async {
    // Do the complete update in a transaction, so that the streams will only
    // update once, after the whole update is ready

    // Important: whenever using transactions, every (!) query / update / insert
    //            inside, has to be awaited -> data loss possible otherwise!
    int count = await dao.transaction(() async {
      int count = 0;

      for(int i = 0; i < taskList.length; i++){
        count += await dao.updateQueuePosition(taskList[i].task.id, i);
      }
      return count;
    });
    return count;

  }

}