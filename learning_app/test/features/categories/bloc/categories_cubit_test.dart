import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/repositories/category_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements CategoryRepository {}

class AnyCreateCategoriesDto extends Mock implements CreateCategoryDto {}

void main() {
  late MockCategoriesRepository mockCategoriesRepository;
  late CategoriesCubit categoriesCubit;

  Category mockCategory =
      const Category(id: 1, name: "Mock Category", color: Colors.red);
  CreateCategoryDto mockCreateDto =
      const CreateCategoryDto(name: "New Category", color: Colors.yellow);
  Stream<List<Category>> mockCategoryStream = Stream.value([mockCategory]);

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    categoriesCubit =
        CategoriesCubit(categoryRepository: mockCategoriesRepository);
  });

  setUpAll(() {
    registerFallbackValue(AnyCreateCategoriesDto());
  });

  group(
    'when calling loadCategories',
    () {
      blocTest<CategoriesCubit, CategoriesState>(
        'CategoriesCubit should fetch all categories and store the result stream',
        build: () {
          when(() => mockCategoriesRepository.watchCategories())
              .thenAnswer((_) => mockCategoryStream);

          return categoriesCubit;
        },
        act: (cubit) async => await cubit.loadCategories(),
        expect: () => [
          CategoriesLoading(),
          CategoriesLoaded(categoriesStream: mockCategoryStream),
        ],
        verify: (_) {
          verify(() => mockCategoriesRepository.watchCategories()).called(1);
        },
      );
    },
  );

  group(
    'when calling createCategory',
    () {
      blocTest<CategoriesCubit, CategoriesState>(
        'CategoriesCubit should create the category',
        build: () {
          when(() => mockCategoriesRepository.createCategory(any()))
              .thenAnswer((_) => Future.value(1));
          return categoriesCubit;
        },
        seed: () => CategoriesLoaded(categoriesStream: Stream.value([])),
        act: (cubit) async => await cubit.createCategory(mockCreateDto),
        verify: (_) {
          verify(() => mockCategoriesRepository.createCategory(mockCreateDto))
              .called(1);
        },
      );
    },
  );

  group(
    'when calling deleteCategory',
    () {
      blocTest<CategoriesCubit, CategoriesState>(
        'CategoriesCubit should delete the category',
        build: () {
          when(() => mockCategoriesRepository.deleteCategoryById(any()))
              .thenAnswer((_) => Future.value(true));
          return categoriesCubit;
        },
        seed: () => CategoriesLoaded(categoriesStream: Stream.value([])),
        act: (cubit) async => await cubit.deleteCategoryById(1),
        verify: (_) {
          verify(() => mockCategoriesRepository.deleteCategoryById(1))
              .called(1);
        },
      );
    },
  );
}
