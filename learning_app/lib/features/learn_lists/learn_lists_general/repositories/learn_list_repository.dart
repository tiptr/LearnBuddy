import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class LearnListRepository {

  // TODO: later include (optional) sorting and filters
  Stream<List<LearnList>> watchLearnLists();

}
