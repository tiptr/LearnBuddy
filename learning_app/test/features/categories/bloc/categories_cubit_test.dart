import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/create_category_dto.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/categories/dtos/update_category_dto.dart';
import 'package:learning_app/features/categories/repositories/category_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements CategoryRepository {}

class AnyCreateCategoriesDto extends Mock implements CreateCategoryDto {}

class AnyUpdateCategoriesDto extends Mock implements UpdateCategoryDto {}

void main() {
  late MockCategoriesRepository mockCategoriesRepository;
  late CategoriesCubit categoriesCubit;

  ReadCategoryDto mockCategory =
      const ReadCategoryDto(id: 1, name: "Mock Category", color: Colors.red);
  CreateCategoryDto mockCreateDto =
      const CreateCategoryDto(name: "New Category", color: Colors.yellow);
  UpdateCategoryDto mockUpdateDto = const UpdateCategoryDto(
      id: 1, name: "New Category", color: Colors.yellow);
  Stream<List<ReadCategoryDto>> mockCategoryStream =
      Stream.value([mockCategory]);

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    categoriesCubit =
        CategoriesCubit(categoryRepository: mockCategoriesRepository);
  });

  setUpAll(() {
    registerFallbackValue(AnyCreateCategoriesDto());
    registerFallbackValue(AnyUpdateCategoriesDto());
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
    'when calling updateCategory',
    () {
      blocTest<CategoriesCubit, CategoriesState>(
        'CategoriesCubit should update the category',
        build: () {
          when(() => mockCategoriesRepository.updateCategory(any()))
              .thenAnswer((_) => Future.value(1));
          return categoriesCubit;
        },
        seed: () => CategoriesLoaded(categoriesStream: Stream.value([])),
        act: (cubit) async => await cubit.updateCategory(mockUpdateDto),
        verify: (_) {
          verify(() => mockCategoriesRepository.updateCategory(mockUpdateDto))
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
