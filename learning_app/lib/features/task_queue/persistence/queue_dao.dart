import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'queue_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/tasks/persistence/task_queue_elements.drift'
  },
)
class QueueDao extends DatabaseAccessor<Database> with _$QueueDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  QueueDao(Database db) : super(db);

  Future<int> updateQueuePosition(int id, int queuePosition) async {
    return (update(taskQueueElements)
          ..where((tuple) => tuple.taskId.equals(id)))
        .write(TaskQueueElementsCompanion(
      taskId: Value(id),
      orderPlacement: Value(queuePosition),
    ));
  }

  Future<int> deleteQueueElementById(int id) async {
    return (delete(taskQueueElements)
          ..where((tuple) => tuple.taskId.equals(id)))
        .go();
  }

  Future<int?> getMaxQueuePosition() async {
    final max = taskQueueElements.orderPlacement.max();
    final query = selectOnly(taskQueueElements)..addColumns([max]);

    return query.map((row) => row.read(max)).getSingle();
  }

  Future<int> addElementToQueueByTaskId(int taskId) async {
    final int maxPos = await getMaxQueuePosition() ?? -1;

    final element = TaskQueueElementsCompanion.insert(
      taskId: Value(taskId),
      addedToQueueDateTime: DateTime.now(),
      orderPlacement: maxPos + 1,
    );

    return into(taskQueueElements).insert(element);
  }
}
