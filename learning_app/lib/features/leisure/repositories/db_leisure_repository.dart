import 'package:injectable/injectable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: LeisureRepository)
class DbLeisureRepository implements LeisureRepository {
  // TODO: daos for category and activity
  // final LeisureActivitiesDao _dao = getIt<TasksDao>();

  @override
  Future<bool> toggleFavorite(int activityId, bool favorite) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();

    // TODO: _leisure_activity_dao.toggleFavorite(int activityId, bool favorite)
  }

  @override
  Stream<List<LeisureCategory>> watchLeisureCategories() {
    // TODO: implement watchLeisureCategories
    throw UnimplementedError();

    // TODO: Use:
    // watchCategoryIdToActivityMap
    // watchLeisureCategoryEntities

    // -> switchMap and Map to get the actual category models with nested activities

    // -> inspiration in _buildListStream inside db_learn_list_repository.dart

  }

}
