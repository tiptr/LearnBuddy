import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/update_key_word_dto.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class KeyWordsRepository {
  Stream<List<ReadKeyWordDto>> watchKeyWords();

  Future<int> createKeyWord(CreateKeyWordDto newKeyWord);

  Future<int> updateKeyWord(UpdateKeyWordDto newKeyWord);

  Future<bool> deleteKeyWordById(int id);
}
