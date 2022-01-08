import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'learn_lists_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/learning_aids/persistence/learn_lists.drift'
  },
)
class LearnListsDao extends DatabaseAccessor<Database>
    with _$LearnListsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  LearnListsDao(Database db) : super(db);
}
