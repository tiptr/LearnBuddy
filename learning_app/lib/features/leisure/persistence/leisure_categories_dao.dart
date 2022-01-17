import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'leisure_categories_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/leisure/persistence/leisure_categories.drift'
  },
)
class LeisureCategoriesDao extends DatabaseAccessor<Database>
    with _$LeisureCategoriesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  LeisureCategoriesDao(Database db) : super(db);

  Stream<List<LeisureCategoryEntity>>? _leisureCategoryEntitiesStream;

  Stream<List<LeisureCategoryEntity>> watchLeisureCategoryEntities() {
    _leisureCategoryEntitiesStream =
        _leisureCategoryEntitiesStream ?? (select(leisureCategories).watch());

    return _leisureCategoryEntitiesStream
        as Stream<List<LeisureCategoryEntity>>;
  }
}
