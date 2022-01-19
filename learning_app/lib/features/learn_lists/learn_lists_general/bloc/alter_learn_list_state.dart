import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/create_learn_list_dto.dart';

abstract class AlterLearnListState {}

class WaitingForAlterLearnListState extends AlterLearnListState {}

class ConstructingNewLearnList extends AlterLearnListState {
  CreateLearnListDto createLearnListDto;

  ConstructingNewLearnList({required this.createLearnListDto});
}
