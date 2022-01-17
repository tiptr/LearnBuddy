import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'task_learn_lists_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/tasks/persistence/task_learn_lists.drift'
  },
)
class TaskLearnListsDao extends DatabaseAccessor<Database>
    with _$TaskLearnListsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TaskLearnListsDao(Database db) : super(db);

  Stream<List<TaskLearnListEntity>>? _taskLearnListEntitiesStream;

  Stream<List<TaskLearnListEntity>> watchTaskLearnListEntities() {
    _taskLearnListEntitiesStream =
        _taskLearnListEntitiesStream ?? (select(taskLearnLists).watch());

    return _taskLearnListEntitiesStream as Stream<List<TaskLearnListEntity>>;
  }

  /// Creates a new task - learn list relationship and returns its id.
  ///
  /// If it already exists, nothing happens, but the id is being returned
  Future<int> createTaskLearnListIfNotExists(
      TaskLearnListsCompanion companion) {
    return into(taskLearnLists).insertOnConflictUpdate(companion);
  }

  /// Creates a new task - learn list relationship and returns its id.
  ///
  /// If it already exists, nothing happens, but the id is being returned
  Future<int> deleteTaskLearnListsForTaskNotInList(
      int taskId, List<int> learnListIds) {
    final deleteStatement = delete(taskLearnLists)
      ..where((tbl) => tbl.listId.isNotIn(learnListIds));

    return deleteStatement.go();
  }
}
