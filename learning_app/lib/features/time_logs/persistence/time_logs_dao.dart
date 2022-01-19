import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

part 'time_logs_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/time_logs/persistence/time_logs.drift'
  },
)
class TimeLogsDao extends DatabaseAccessor<Database> with _$TimeLogsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TimeLogsDao(Database db) : super(db);

  Stream<List<TimeLogEntity>>? _timeLogEntitiesStream;
  Stream<Map<int, List<TimeLog>>>? _taskIdToTimeLogsMapStream;

  Stream<List<TimeLogEntity>> watchAllTimeLogEntities() {
    _timeLogEntitiesStream =
        _timeLogEntitiesStream ?? (select(timeLogs).watch());

    return _timeLogEntitiesStream as Stream<List<TimeLogEntity>>;
  }

  /// Returns a stream of maps that associate a Task id with the TimeLogs
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, List<TimeLog>>> watchTaskIdToTimeLogsMap() {
    _taskIdToTimeLogsMapStream =
        (_taskIdToTimeLogsMapStream ?? (_createIdToTimeLogMapStream()));

    return _taskIdToTimeLogsMapStream as Stream<Map<int, List<TimeLog>>>;
  }

  /// Creates a stream of maps that associate the Task id with the TimeLogs
  Stream<Map<int, List<TimeLog>>> _createIdToTimeLogMapStream() {
    final Stream<List<TimeLogEntity>> timeLogEntitiesStream =
        watchAllTimeLogEntities();

    return timeLogEntitiesStream.map((timeLogs) {
      final idToModelList = <int, List<TimeLog>>{};

      for (var entity in timeLogs) {
        final model = TimeLog(
          id: entity.id,
          taskId: entity.taskId,
          beginTime: entity.beginDateTime,
          duration: entity.duration,
        );
        idToModelList.putIfAbsent(entity.taskId, () => []).add(model);
      }
      return idToModelList;
    });
  }

  Future<int> createTimeLog(TimeLogsCompanion timeLogsCompanion) {
    return into(timeLogs).insert(timeLogsCompanion);
  }

  Future<int> updateTimeLog(int id, Duration duration) {
    return (update(timeLogs)..where((tuple) => tuple.id.equals(id)))
        .write(TimeLogsCompanion(
      duration: Value(duration),
    ));
  }

  Future<void> deleteTimeLogsByTaskId(int id) {
    final deleteStatement = delete(timeLogs)
      ..where((tbl) => tbl.taskId.equals(id));

    return deleteStatement.go();
  }
}
