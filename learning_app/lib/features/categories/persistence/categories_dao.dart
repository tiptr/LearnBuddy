import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';

// Also import the used model(s), as they are required in the generated extension file
import 'package:learning_app/features/categories/models/category.dart';

part 'categories_dao.g.dart';

/// Data access object to structure all related queries
///
/// This is not strictly required, but helps structuring the project. Without the
/// definition of DAOs, all queries would be accessible directly through the Database.
/// The _TodosDaoMixin will be created by drift. It contains all the necessary
/// fields for the tables. The <MyDatabase> type annotation is the database class
/// that should use this dao.
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/categories/persistence/categories.drift'
  },
)
class CategoriesDao extends DatabaseAccessor<Database>
    with _$CategoriesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  CategoriesDao(Database db) : super(db);

  Stream<List<ReadCategoryDto>>? _categoriesStream;
  Stream<Map<int, Category>>? _idToCategoryMapStream;

  Future<int> createCategory(CategoriesCompanion categoriesCompanion) {
    // insertReturning() already provides the whole created entity instead of
    // the single ID provided by insert()
    // this was changed back to insert(), because now, we do not need the 'task'
    // anymore for displaying the list, but rather a 'ListReadTaskDto'

    return into(categories).insert(categoriesCompanion);
  }

  Future<int> updateCategory(CategoriesCompanion categoriesCompanion) {
    var updateStmnt = (update(categories)
      ..where(
        (t) => t.id.equals(categoriesCompanion.id.value),
      ));

    return updateStmnt.write(categoriesCompanion);
  }

  Future<int> deleteCatgoryById(int categoryId) {
    return (delete(categories)..where((t) => t.id.equals(categoryId))).go();
  }

  Stream<List<ReadCategoryDto>> watchAllCategories() {
    _categoriesStream = _categoriesStream ??
        (select(categories)
            .map((row) =>
                ReadCategoryDto(id: row.id, name: row.name, color: row.color))
            .watch());

    return _categoriesStream as Stream<List<ReadCategoryDto>>;
  }

  /// Returns a stream of maps that associate the category id with the category
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, Category>> watchIdToCategoryMap() {
    _idToCategoryMapStream =
        (_idToCategoryMapStream ?? (_createIdToCategoryMapStream()));

    return _idToCategoryMapStream as Stream<Map<int, Category>>;
  }

  /// Creates a stream of maps that associate the category id with the category
  Stream<Map<int, Category>> _createIdToCategoryMapStream() {
    final Stream<List<ReadCategoryDto>> categoriesStream = watchAllCategories();
    return categoriesStream.map((models) {
      final idToModel = <int, Category>{};
      for (var model in models) {
        idToModel.putIfAbsent(
          model.id,
          () => Category(
            id: model.id,
            color: model.color,
            name: model.name,
          ),
        );
      }
      return idToModel;
    });
  }
}
