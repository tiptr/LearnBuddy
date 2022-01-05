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
}
