import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';

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

  Stream<List<LeisureActivity>>? _activitiesStream;
  Stream<Map<int, List<LeisureActivity>>>? _idToActivityMapStream;

  /// Returns a stream of maps that associate the category id with the category
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, List<LeisureActivity>>> watchCategoryIdToActivityMap() {
    _idToActivityMapStream =
        (_idToActivityMapStream ?? (_createIdToActivityMapStream()));

    return _idToActivityMapStream as Stream<Map<int, List<LeisureActivity>>>;
  }

  /// Creates a stream of maps that associate the category id with the category
  Stream<Map<int, List<LeisureActivity>>> _createIdToActivityMapStream() {
    final Stream<List<LeisureActivity>> activitiesStream = watchAllActivities();
    return activitiesStream.map((activityList) {
      final idToModel = <int, List<LeisureActivity>>{};
      for (var activity in activityList) {
        idToModel.putIfAbsent(activity.categoryId, () => []).add(activity);
      }
      return idToModel;
    });
  }

  Stream<List<LeisureActivity>> watchAllActivities() {
    _activitiesStream = _activitiesStream ??
        (select(leisureActivities)
            .map((row) => LeisureActivity(
                id: row.id,
                categoryId: row.leisureCategoryId,
                name: row.name,
                duration: row.duration,
                descriptionShort: row.descriptionShort,
                descriptionLong: row.descriptionLong,
                isFavorite: row.isFavorite,
                pathToImage: row.pathToImage))
            .watch());

    return _activitiesStream as Stream<List<LeisureActivity>>;
  }

  Future<int> toggleActivityFavoriteById(int activityId, bool favorite) {
    Value<bool> newIsFavorite = Value(favorite);

    return (update(leisureActivities)..where((t) => t.id.equals(activityId)))
        .write(LeisureActivitiesCompanion(isFavorite: newIsFavorite));
  }
}
