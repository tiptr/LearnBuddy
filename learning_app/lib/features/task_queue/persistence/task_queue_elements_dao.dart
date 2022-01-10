import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'task_queue_elements_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/task_queue/persistence/task_queue_elements.drift'
  },
)
class TaskQueueElementsDao extends DatabaseAccessor<Database>
    with _$TaskQueueElementsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TaskQueueElementsDao(Database db) : super(db);

  Stream<List<TaskQueueElementEntity>>? _queueEntitiesStream;
  Stream<Map<int, int>>? _taskIdToQueuePlacementMapStream;

  Stream<List<TaskQueueElementEntity>> watchAllQueueEntities() {
    _queueEntitiesStream =
        _queueEntitiesStream ?? (select(taskQueueElements).watch());

    return _queueEntitiesStream as Stream<List<TaskQueueElementEntity>>;
  }

  /// Returns a stream of maps that associate the task id with it's queue
  /// placement (Tasks, that are not queued, will not be in this map)
  Stream<Map<int, int>> watchTaskIdToQueuePlacementMap() {
    _taskIdToQueuePlacementMapStream = (_taskIdToQueuePlacementMapStream ??
        (_createTaskIdToQueuePlacementMapStream()));

    return _taskIdToQueuePlacementMapStream as Stream<Map<int, int>>;
  }

  /// Creates a stream of maps that associate the task id with it's queue
  /// placement
  Stream<Map<int, int>> _createTaskIdToQueuePlacementMapStream() {
    final Stream<List<TaskQueueElementEntity>> queueEntitiesStream =
        watchAllQueueEntities();
    return queueEntitiesStream.map((models) {
      final idToPlacement = <int, int>{};
      for (var model in models) {
        idToPlacement.putIfAbsent(model.taskId, () => model.orderPlacement);
      }
      return idToPlacement;
    });
  }
}
