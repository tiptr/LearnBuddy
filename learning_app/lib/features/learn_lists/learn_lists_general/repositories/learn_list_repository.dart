import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class LearnListRepository {
  // TODO: later include (optional) sorting and filters
  // TODO: but make the default 'not filtered', since the task list depends on it
  Stream<List<LearnList>> watchLearnLists();

  Stream<Map<int, LearnList>> watchIdToLearnListMap();
}
