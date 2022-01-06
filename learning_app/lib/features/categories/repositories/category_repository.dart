import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/models/category.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class CategoryRepository {
  Stream<List<Category>> watchCategories();

  Future<int> createCategory(CreateCategoryDto newCategory);

  Future<bool> deleteCategoryById(int id);
}
