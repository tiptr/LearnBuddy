import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class CategoryRepository {
  Future<List<ReadCategoryDto>> loadCategories();

  Future<int> createCategory(CreateCategoryDto newCategory);

  Future<bool> deleteCategoryById(int id);
}
