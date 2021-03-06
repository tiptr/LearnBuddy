import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/update_key_word_dto.dart';
import 'package:learning_app/features/keywords/persistence/keywords_dao.dart';
import 'package:learning_app/features/keywords/repositories/keyword_repository.dart';
import 'package:learning_app/features/tasks/persistence/task_keywords_dao.dart';
import 'package:learning_app/util/injection.dart';

/// Concrete repositories implementation using the database with drift
@Injectable(as: KeyWordsRepository)
class DbKeyWordRepository implements KeyWordsRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final KeyWordsDao _dao = getIt<KeyWordsDao>();
  final TaskKeywordsDao _taskKeywordsDao = getIt<TaskKeywordsDao>();

  @override
  Future<int> createKeyWord(CreateKeyWordDto newKeyWordDto) {
    return _dao.createKeyWord(KeywordsCompanion(
      name: Value(newKeyWordDto.name),
    ));
  }

  @override
  Future<int> updateKeyWord(UpdateKeyWordDto updateKeyWordDto) {
    return _dao.updateKeyWord(KeywordsCompanion(
      id: Value(updateKeyWordDto.id),
      name: Value(updateKeyWordDto.name),
    ));
  }

  @override
  Future<bool> deleteKeyWordById(int id) async {
    return await _dao.transaction(() async {
      await _taskKeywordsDao.deleteTaskKeyWordsByKeyWordId(id);

      var affected = await _dao.deleteKeyWordById(id);
      return affected > 0;
    });
  }

  @override
  Stream<List<ReadKeyWordDto>> watchKeyWords() {
    return _dao.watchAllKeyWords().map((keyWordEntities) {
      return keyWordEntities
          .map((e) => ReadKeyWordDto.fromKeywordEntity(e))
          .toList();
    });
  }
}
