import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class LeisureRepository {
  Stream<List<LeisureCategory>> watchLeisureCategories();

  Future<bool> toggleFavorite(int activityId, bool favorite);

  Stream<LeisureActivity> watchRandomLeisureActivity();
}
