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

  Stream<List<LeisureActivities>>? _activitiesStream;
  Stream<Map<int, LeisureActivities>>? _idToActivityMapStream;

  //TODO: watchCategoryIdToActivityMap
  // ->  stream of map of <int, LeisureActivity>
  // -> inspiration on how to do this in 'keywords_dao.dart' -> watchIdToKeywordMap


  /// Returns a stream of maps that associate the category id with the category
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, LeisureActivities>> watchCategoryIdToActivityMap() {
    _idToActivityMapStream =
        (_idToActivityMapStream ?? (_createIdToActivityMapStream()));

    return _idToActivityMapStream as Stream<Map<int, LeisureActivities>>;
  }

  /// Creates a stream of maps that associate the category id with the category
  Stream<Map<int, LeisureActivities>> _createIdToActivityMapStream() {
    final Stream<List<LeisureActivities>> activitiesStream = watchAllActivities();
    return activitiesStream.map((models) {
      final idToModel = <int, LeisureActivities>{};
      for (var model in models) {
        idToModel.putIfAbsent(model.id, () => model);
      }
      return idToModel;
    });
  }

  //TODO: Müsste das hier nicht leisure activity sein? Und oben auch? -> aber das gibt es nicht
  Stream<List<LeisureActivities>> watchAllActivities() {
    _activitiesStream = _activitiesStream ??
        (select(leisureActivities)
            .map(
                (row) => LeisureActivity(id: row.id, name: row.name, duration: row.duration, descriptionShort: row.descriptionShort, isFavorite: row.isFavorite))
            .watch());

    return _activitiesStream as Stream<List<LeisureActivities>>;
  }


  Future<int> toggleActivityFavoriteById(int activityId, bool favorite) {
    Value<bool> newIsFavorite = Value(favorite);

    return (update(leisureActivities)..where((t) => t.id.equals(activityId))).write(
      LeisureActivitiesCompanion(isFavorite: newIsFavorite)
    );
  }
}
