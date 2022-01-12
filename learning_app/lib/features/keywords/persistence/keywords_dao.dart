import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';

part 'keywords_dao.g.dart';

/// Data access object to structure all related queries
///
/// This contains the queries and insert / update features to access the
/// related entity
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {
    'package:learning_app/features/keywords/persistence/keywords.drift'
  },
)
class KeyWordsDao extends DatabaseAccessor<Database> with _$KeyWordsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  KeyWordsDao(Database db) : super(db);

  Stream<List<ReadKeyWordDto>>? _keyWordsStream;
  Stream<Map<int, KeyWord>>? _idToKeyWordMapStream;

  Future<int> createKeyWord(KeywordsCompanion keyWordsCompanion) {
    return into(keywords).insert(keyWordsCompanion);
  }

  Future<int> updateKeyWord(KeywordsCompanion keyWordsCompanion) {
    var updateStmnt = (update(keywords)
      ..where(
        (t) => t.id.equals(keyWordsCompanion.id.value),
      ));

    return updateStmnt.write(keyWordsCompanion);
  }

  Future<int> deleteKeyWordById(int keyWordId) {
    return (delete(keywords)..where((t) => t.id.equals(keyWordId))).go();
  }

  Stream<List<ReadKeyWordDto>> watchAllKeyWords() {
    _keyWordsStream = _keyWordsStream ??
        (select(keywords)
            .map((row) => ReadKeyWordDto(id: row.id, name: row.name))
            .watch());

    return _keyWordsStream as Stream<List<ReadKeyWordDto>>;
  }

  /// Returns a stream of maps that associate the keyword id with the keyword
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, KeyWord>> watchIdToKeywordMap() {
    _idToKeyWordMapStream =
        (_idToKeyWordMapStream ?? (_createIdToKeyWordMapStream()));

    return _idToKeyWordMapStream as Stream<Map<int, KeyWord>>;
  }

  /// Creates a stream of maps that associate the keyword id with the keyword
  Stream<Map<int, KeyWord>> _createIdToKeyWordMapStream() {
    final Stream<List<ReadKeyWordDto>> keyWordsStream = watchAllKeyWords();
    return keyWordsStream.map((models) {
      final idToModel = <int, KeyWord>{};
      for (var model in models) {
        idToModel.putIfAbsent(
          model.id,
          () => KeyWord(id: model.id, name: model.name),
        );
      }
      return idToModel;
    });
  }
}
