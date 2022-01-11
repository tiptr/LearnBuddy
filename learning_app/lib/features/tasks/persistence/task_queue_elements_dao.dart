import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/tasks/models/queue_status.dart';

part 'task_queue_elements_dao.g.dart';

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
class TaskQueueElementsDao extends DatabaseAccessor<Database>
    with _$TaskQueueElementsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TaskQueueElementsDao(Database db) : super(db);

  Stream<List<TaskQueueElementEntity>>? _queueEntitiesStream;
  Stream<Map<int, QueueStatus>>? _taskIdToQueueStatusMapStream;

  Stream<List<TaskQueueElementEntity>> watchAllQueueEntities() {
    _queueEntitiesStream =
        _queueEntitiesStream ?? (select(taskQueueElements).watch());

    return _queueEntitiesStream as Stream<List<TaskQueueElementEntity>>;
  }

  /// Returns a stream of maps that associate the task id with it's queue
  /// status (Tasks, that are not queued, will not be in this map)
  Stream<Map<int, QueueStatus>> watchTaskIdToQueueStatusMap() {
    _taskIdToQueueStatusMapStream = (_taskIdToQueueStatusMapStream ??
        (_createTaskIdToQueueStatusMapStream()));

    return _taskIdToQueueStatusMapStream as Stream<Map<int, QueueStatus>>;
  }

  /// Creates a stream of maps that associate the task id with it's queue
  /// status
  Stream<Map<int, QueueStatus>> _createTaskIdToQueueStatusMapStream() {
    final Stream<List<TaskQueueElementEntity>> queueEntitiesStream =
        watchAllQueueEntities();
    return queueEntitiesStream.map((models) {
      final idToPlacement = <int, QueueStatus>{};
      for (var model in models) {
        idToPlacement.putIfAbsent(
            model.taskId,
            () => QueueStatus(
                  queuePlacement: model.orderPlacement,
                  addedToQueueDateTime: model.addedToQueueDateTime,
                ));
      }
      return idToPlacement;
    });
  }
}
