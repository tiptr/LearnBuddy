import 'dart:ui';
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

  Future<int> createCategory(CategoriesCompanion categoriesCompanion) {
    // insertReturning() already provides the whole created entity instead of
    // the single ID provided by insert()
    // this was changed back to insert(), because now, we do not need the 'task'
    // anymore for displaying the list, but rather a 'ListReadTaskDto'

    return into(categories).insert(categoriesCompanion);
  }

  Future<List<ReadCategoryDto>> getAllCategories() {
    final query = select(categories).map(
        (row) => ReadCategoryDto(id: row.id, name: row.name, color: row.color));
    return query.get();
  }

  Future<int> deleteCatgoryById(int categoryId) {
    return (delete(categories)..where((t) => t.id.equals(categoryId))).go();
  }
}
