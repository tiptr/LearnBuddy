import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class KeyWordsRepository {
  Stream<List<KeyWord>> watchKeyWords();

  Future<int> createKeyWord(CreateKeyWordDto newKeyWord);

  Future<bool> deleteKeyWordById(int id);
}
