import 'package:injectable/injectable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: LeisureRepository)
class DbLeisureRepository implements LeisureRepository {
  @override
  Future<bool> toggleFavorite(int activityId, bool favorite) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Stream<List<LeisureCategory>> watchLeisureCategories() {
    // TODO: implement watchLeisureCategories
    throw UnimplementedError();
  }
  // load the data access object (with generated entities and queries) via dependency inj.
  // final LeisureActivitiesDao _dao = getIt<TasksDao>();
  // final LeisureActivitiesDao _dao = getIt<TasksDao>();
  //
  // Stream<List<LeisureCategory>> watchLeisureCategories({
  //   int? limit,
  //   int? offset,
  //   TaskFilter taskFilter,
  //   TaskOrder taskOrder,
  // });
  //
  // Future<bool> toggleFavorite(int activityId, bool favorite);
}
