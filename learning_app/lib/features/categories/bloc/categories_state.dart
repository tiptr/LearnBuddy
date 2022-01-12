import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialCategoriesState extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final Stream<List<ReadCategoryDto>> categoriesStream;

  CategoriesLoaded({required this.categoriesStream});

  @override
  List<Object> get props => [categoriesStream];
}
