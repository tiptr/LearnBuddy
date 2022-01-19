import 'package:learning_app/features/leisure/dtos/read_leisure_categories_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';

abstract class LeisureState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLeisuresState extends LeisureState {}

// TODO: refactor LeisureCategory to hold the filters rather than the stream
// ignore: must_be_immutable
class LeisuresLoaded extends LeisureState {
  Stream<List<LeisureCategory>> selectedLeisureCategoriesStream;
  late Stream<List<ReadLeisureCategoriesDto>> listViewLeisureCategoriesStream;

  LeisuresLoaded({required this.selectedLeisureCategoriesStream}) {
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
