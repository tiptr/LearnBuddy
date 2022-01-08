import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialCategoriesState extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final Stream<List<Category>> categoriesStream;

  CategoriesLoaded({required this.categoriesStream});

  @override
  List<Object> get props => [categoriesStream];
}
