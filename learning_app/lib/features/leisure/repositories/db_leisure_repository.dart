import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/features/leisure/persistence/leisure_categories_dao.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'dart:core';
import 'package:learning_app/util/injection.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: LeisureRepository)
class DbLeisureRepository implements LeisureRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final LeisureCategoriesDao _leisureCategoriesDao = getIt<LeisureCategoriesDao>();
  final LeisureActivitiesDao _leisureActivitiesDao = getIt<LeisureActivitiesDao>();

  Stream<List<LeisureCategory>>? _leisureCategoryStream;

  @override
  Future<bool> toggleFavorite(int activityId, bool favorite) async {
    final affected = await _leisureActivitiesDao.toggleActivityFavoriteById(activityId, favorite);
    return affected > 0;
  }

  @override
  Stream<List<LeisureCategory>> watchLeisureCategories() {
    _leisureCategoryStream = _leisureCategoryStream ?? (_buildListStream());
    return _leisureCategoryStream as Stream<List<LeisureCategory>>;

    // TODO: Use:
    // watchCategoryIdToActivityMap
    // watchLeisureCategoryEntities

    // -> switchMap and Map to get the actual category models with nested activities

    // -> inspiration in _buildListStream inside db_learn_list_repository.dart

  }

    /// Actually creates the stream. To be called only once.
  Stream<List<LeisureCategory>> _buildListStream() {
    final Stream<List<LeisureCategoryEntity>> leisureCategoryEntitiesStream =
        _leisureCategoriesDao.watchLeisureCategoryEntities();

    final Stream<Map<int, LeisureActivities>> leisureCategoryIdToActivityMapStream =
        _leisureActivitiesDao.watchCategoryIdToActivityMap();


    //TODO: wie genau wird das jetzt geswitchMapped?
  }


/*
    final Stream<List<LearnListEntity>> learnListEntitiesStream =
        _learnListDao.watchLearnListEntities();

    final Stream<List<LearnListWordEntity>> learnListWordEntitiesStream =
        _learnListWordsDao.watchLearnListWordEntities();

    final Stream<List<BodyListWordDetailEntity>>
        bodyListWordDetailEntitiesStream =
        _bodyListWordDetailsDao.watchBodyListWordDetailEntities();

    final Stream<Map<int, Category>> idToCategoryMapStream =
        _categoriesDao.watchIdToCategoryMap();

    // This will be called whenever the learn lists change:
    return idToCategoryMapStream.switchMap((idToCategoryMap) {
      // This will be called whenever the learn lists change:
      return learnListEntitiesStream.switchMap((learnLists) {
        // Merge it all together and build a stream of task-models
        return learnListWordEntitiesStream.switchMap((words) {
          // Create a map to efficiently allocate the words by their parent list
          // this maps are generated as low in the stream-chain as possible, so
          // they will not have to be created at every update in the inner chain
          final listIdToWordsMap = _createListIdToWordsMap(words);

          // This will be called whenever the body list word details change:
          return bodyListWordDetailEntitiesStream.map((bodyWordDetails) {
            final wordIdToBodyDetailsMap =
                _createWordIdToBodyDetailsMap(bodyWordDetails);

            return _mergeEntitiesTogether(
              learnLists: learnLists,
              listIdToWordsMap: listIdToWordsMap,
              wordIdToBodyDetailsMap: wordIdToBodyDetailsMap,
              idToCategoryMap: idToCategoryMap,
            );
          });
        });
      });
    });*/

}
