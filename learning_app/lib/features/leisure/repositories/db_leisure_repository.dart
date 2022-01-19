import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/features/leisure/persistence/leisure_categories_dao.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'dart:core';
import 'package:learning_app/util/injection.dart';
import 'package:rxdart/rxdart.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: LeisureRepository)
class DbLeisureRepository implements LeisureRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final LeisureCategoriesDao _leisureCategoriesDao =
      getIt<LeisureCategoriesDao>();
  final LeisureActivitiesDao _leisureActivitiesDao =
      getIt<LeisureActivitiesDao>();

  Stream<List<LeisureCategory>>? _leisureCategoryStream;

  @override
  Future<bool> toggleFavorite(int activityId, bool favorite) async {
    final affected = await _leisureActivitiesDao.toggleActivityFavoriteById(
      activityId,
      favorite,
    );
    return affected > 0;
  }

  @override
  Stream<List<LeisureCategory>> watchLeisureCategories() {
    _leisureCategoryStream = _leisureCategoryStream ?? (_buildListStream());
    return _leisureCategoryStream as Stream<List<LeisureCategory>>;
  }

  /// Actually creates the stream. To be called only once.
  Stream<List<LeisureCategory>> _buildListStream() {
    final Stream<List<LeisureCategoryEntity>> leisureCategoryEntitiesStream =
        _leisureCategoriesDao.watchLeisureCategoryEntities();

    final Stream<Map<int, List<LeisureActivity>>>
        leisureCategoryIdToActivityMapStream =
        _leisureActivitiesDao.watchCategoryIdToActivityMap();

    return leisureCategoryEntitiesStream.switchMap(
      (categoryList) {
        return leisureCategoryIdToActivityMapStream.map(
          (categoryIdToActivitiesMap) {
            final List<LeisureCategory> resultList = [];
            for (var category in categoryList) {
              resultList.add(
                LeisureCategory(
                  id: category.id,
                  name: category.name,
                  pathToImage: category.pathToImage,
                  activities: categoryIdToActivitiesMap[category.id] ?? [],
                ),
              );
            }
            return resultList;
          },
        );
      },
    );
  }

  @override
  Stream<LeisureActivity> watchRandomLeisureActivity() {
    final leisureCategoriesStream = watchLeisureCategories();
    Stream<LeisureActivity> leisureActivityStream =
        leisureCategoriesStream.map((leisureCategories) {
      Random random = Random();
      int randInt = random.nextInt(leisureCategories.length);
      // TODO: check if there is a element in the category

      final LeisureCategory randomLeisureCategory = leisureCategories[randInt];
      randInt = random.nextInt(randomLeisureCategory.activities.length);
      final LeisureActivity randomLeisureActivity =
          randomLeisureCategory.activities[randInt];
      return randomLeisureActivity;
    });
    return leisureActivityStream;
  }
}
