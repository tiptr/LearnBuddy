import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/learn_lists_state.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/util/injection.dart';

class LearnListsCubit extends Cubit<LearnListsState> {
  late final LearnListRepository _learnListRepository;

  LearnListsCubit({LearnListRepository? learnListRepository})
      : super(InitialLearnListState()) {
    _learnListRepository = learnListRepository ?? getIt<LearnListRepository>();
  }

  Future<void> loadLearnLists() async {
    emit(LearnListLoading());
    var learnList = _learnListRepository.watchLearnLists();
    emit(LearnListLoaded(selectedLearnListsStream: learnList));
  }

  Stream<ReadLearnListDto> watchLearnListById({required int learnListId}) {
    final currentState = state;
    if (currentState is LearnListLoaded) {
      return currentState.selectedListViewlearnListsStream.map((learnList) =>
          learnList.firstWhere((list) => list.id == learnListId));
    } else {
      throw InvalidStateException();
    }
  }
}
