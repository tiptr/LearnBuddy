import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';
import 'package:learning_app/util/injection.dart';

import 'category_repository.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: CategoryRepository)
class DbCategoryRepository implements CategoryRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final CategoriesDao _dao = getIt<CategoriesDao>();

  @override
  Future<int> createCategory(CreateCategoryDto newCategory) {
    return _dao.createCategory(CategoriesCompanion(
      name: Value(newCategory.name),
      color: Value(newCategory.color),
    ));
  }

  @override
  Future<bool> deleteCategoryById(int id) async {
    final affected = await _dao.deleteCatgoryById(id);
    return affected > 0;
  }

  @override
  Future<List<ReadCategoryDto>> loadCategories() {
    return _dao.getAllCategories();
  }
}
