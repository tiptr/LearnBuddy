import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'leisure_activities_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/leisure/persistence/leisure_activities.drift'
  },
)
class LeisureActivitiesDao extends DatabaseAccessor<Database>
    with _$LeisureActivitiesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  LeisureActivitiesDao(Database db) : super(db);

  //TODO: watchCategoryIdToActivityMap
  // ->  stream of map of <int, LeisureActivity>
  // -> inspiration on how to do this in 'keywords_dao.dart' -> watchIdToKeywordMap

  // TODO: toggleFavorite() like this:
  // Future<int> toggleTaskDoneById(int taskId, bool done) {
  //   Value<DateTime?> newDoneDateTime = const Value(null);
  //
  //   if (done) {
  //     newDoneDateTime = Value(DateTime.now());
  //   }
  //
  //   return (update(tasks)..where((t) => t.id.equals(taskId))).write(
  //     TasksCompanion(
  //       doneDateTime: newDoneDateTime,
  //     ),
  //   );
  // }
}
