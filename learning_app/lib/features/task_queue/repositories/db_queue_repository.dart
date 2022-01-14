import 'package:injectable/injectable.dart';
import 'package:learning_app/features/task_queue/persistence/queue_dao.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/util/injection.dart';

@Injectable(as: QueueRepository)
class DbQueueRepository implements QueueRepository {

  final QueueDao dao = getIt<QueueDao>();

  @override
  Future<void> writeQueueOrder(List<TaskWithQueueStatus> taskList) async {
    taskList.asMap().forEach((int index, TaskWithQueueStatus taskWithQueueStatus) {
      dao.updateQueuePosition(taskWithQueueStatus.task.id, index);
    });
    return;

  }

}