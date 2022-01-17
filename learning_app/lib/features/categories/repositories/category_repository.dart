import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/dtos/update_category_dto.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class CategoryRepository {
  Stream<List<ReadCategoryDto>> watchCategories();

  Future<int> createCategory(CreateCategoryDto newCategory);

  Future<int> updateCategory(UpdateCategoryDto updateCategory);

  Future<bool> deleteCategoryById(int id);
}
