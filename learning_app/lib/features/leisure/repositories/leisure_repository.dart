import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class LeisureRepository {
  Stream<List<LeisureCategory>> watchLeisureCategories();

  Future<bool> toggleFavorite(int activityId, bool favorite);

}
