import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'task_keywords_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/tasks/persistence/task_keywords.drift'
  },
)
class TaskKeywordsDao extends DatabaseAccessor<Database>
    with _$TaskKeywordsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TaskKeywordsDao(Database db) : super(db);

  Stream<List<TaskKeywordEntity>>? _taskKeyWordEntitiesStream;

  Stream<List<TaskKeywordEntity>> watchTaskKeyWordEntities() {
    _taskKeyWordEntitiesStream =
        _taskKeyWordEntitiesStream ?? (select(taskKeywords).watch());

    return _taskKeyWordEntitiesStream as Stream<List<TaskKeywordEntity>>;
  }

  /// Creates a new task-keyword relationship and returns its id.
  ///
  /// If it already exists, nothing happens, but the id is being returned
  Future<int> createTaskKeyWordIfNotExists(TaskKeywordsCompanion companion) {
    return into(taskKeywords).insertOnConflictUpdate(companion);
  }

  /// Removes
  Future<int> deleteTaskKeyWordsForTaskNotInList(
    int taskId,
    List<int> keyWordIds,
  ) {
    final deleteStatement = delete(taskKeywords)
      ..where((tbl) => tbl.taskId.equals(taskId))
      ..where((tbl) => tbl.keywordId.isNotIn(keyWordIds));

    return deleteStatement.go();
  }

  Future<void> deleteTaskKeyWordsByKeyWordId(int id) {
    final deleteStatement = delete(taskKeywords)
      ..where((tbl) => tbl.keywordId.equals(id));

    return deleteStatement.go();
  }

  Future<void> deleteTaskKeyWordsByTaskId(int id) {
    final deleteStatement = delete(taskKeywords)
      ..where((tbl) => tbl.taskId.equals(id));

    return deleteStatement.go();
  }
}
