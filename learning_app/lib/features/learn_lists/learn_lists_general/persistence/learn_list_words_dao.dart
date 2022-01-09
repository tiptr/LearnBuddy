import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'learn_list_words_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_list_words.drift'
  },
)
class LearnListWordsDao extends DatabaseAccessor<Database>
    with _$LearnListWordsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  LearnListWordsDao(Database db) : super(db);

  Stream<List<LearnListWordEntity>>? _learnListWordsEntitiesStream;

  Stream<List<LearnListWordEntity>> watchLearnListWordEntities() {
    _learnListWordsEntitiesStream =
        _learnListWordsEntitiesStream ?? (select(learnListWords).watch());

    return _learnListWordsEntitiesStream as Stream<List<LearnListWordEntity>>;
  }
}
