import 'package:learning_app/features/leisure/dtos/read_leisure_categories_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';

abstract class LeisureCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLeisureCategoryState extends LeisureCategoryState {}

// TODO: refactor LeisureCategory to hold the filters rather than the stream
// ignore: must_be_immutable
class LeisureCategoryLoaded extends LeisureCategoryState {
  Stream<List<LeisureCategory>> selectedLeisureCategoriesStream;
  late Stream<List<ReadLeisureCategoriesDto>> listViewLeisureCategoriesStream;

  LeisureCategoryLoaded({required this.selectedLeisureCategoriesStream}) {
    listViewLeisureCategoriesStream =
        selectedLeisureCategoriesStream.map((categoryList) {
      return categoryList
          .map((category) =>
              ReadLeisureCategoriesDto.fromLeisureCategory(category))
          .toList();
    });
  }

  @override
  List<Object> get props => [listViewLeisureCategoriesStream];
}
