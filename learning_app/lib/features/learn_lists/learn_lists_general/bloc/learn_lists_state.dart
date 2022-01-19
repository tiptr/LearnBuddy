import 'package:equatable/equatable.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';

abstract class LearnListsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLearnListState extends LearnListsState {}

class LearnListLoading extends LearnListsState {}

// ignore: must_be_immutable
class LearnListLoaded extends LearnListsState {
  Stream<List<LearnList>> selectedLearnListsStream;
  late Stream<List<ReadLearnListDto>> selectedListViewlearnListsStream;

  LearnListLoaded({required this.selectedLearnListsStream}) {
    selectedListViewlearnListsStream =
        selectedLearnListsStream.map((learnListsList) {
      return learnListsList
          .map((learnList) => ReadLearnListDto.fromLearnList(learnList))
          .toList();
    });
  }

  @override
  List<Object> get props => [selectedLearnListsStream];
}
