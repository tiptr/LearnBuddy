import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/repositories/category_repository.dart';
import 'package:learning_app/util/injection.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  late final CategoryRepository _categoryRepository;

  CategoriesCubit({CategoryRepository? categoryRepository})
      : super(InitialCategoriesState()) {
    _categoryRepository = categoryRepository ?? getIt<CategoryRepository>();
  }

  Future<void> loadCategories() async {
    emit(CategoriesLoading());
    var stream = _categoryRepository.watchCategories();
    emit(CategoriesLoaded(categoriesStream: stream));
  }

  Future<void> createCategory(CreateCategoryDto newCategory) async {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      await _categoryRepository.createCategory(newCategory);
    }
  }

  Future<void> deleteCategoryById(int id) async {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      await _categoryRepository.deleteCategoryById(id);
    }
  }
}
