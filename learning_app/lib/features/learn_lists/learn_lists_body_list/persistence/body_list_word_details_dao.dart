import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

part 'body_list_word_details_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/learn_lists/learn_lists_body_list/persistence/body_list_word_details.drift'
  },
)
class BodyListWordDetailsDao extends DatabaseAccessor<Database>
    with _$BodyListWordDetailsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  BodyListWordDetailsDao(Database db) : super(db);

  Stream<List<BodyListWordDetailEntity>>? _bodyListWordDetailEntitiesStream;

  Stream<List<BodyListWordDetailEntity>> watchBodyListWordDetailEntities() {
    _bodyListWordDetailEntitiesStream = _bodyListWordDetailEntitiesStream ??
        (select(bodyListWordDetails).watch());

    return _bodyListWordDetailEntitiesStream
        as Stream<List<BodyListWordDetailEntity>>;
  }

  Future<int> createBodyListWord(
      BodyListWordDetailsCompanion bodyListWordDetailsCompanion) {
    return into(bodyListWordDetails).insert(bodyListWordDetailsCompanion);
  }
}
