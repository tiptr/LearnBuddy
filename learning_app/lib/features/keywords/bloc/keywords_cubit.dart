import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/update_key_word_dto.dart';
import 'package:learning_app/features/keywords/repositories/keyword_repository.dart';
import 'package:learning_app/util/injection.dart';

class KeyWordsCubit extends Cubit<KeyWordsState> {
  late final KeyWordsRepository _keywordRepository;

  KeyWordsCubit({KeyWordsRepository? keywordRepository})
      : super(InitialKeyWordsState()) {
    _keywordRepository = keywordRepository ?? getIt<KeyWordsRepository>();
  }

  Future<void> loadKeyWords() async {
    emit(KeyWordsLoading());
    var stream = _keywordRepository.watchKeyWords();
    emit(KeyWordsLoaded(keywordsStream: stream));
  }

  Future<void> createKeyWord(CreateKeyWordDto newKeyWordDto) async {
    final currentState = state;
    if (currentState is KeyWordsLoaded) {
      await _keywordRepository.createKeyWord(newKeyWordDto);
    }
  }

  Future<void> updateKeyWord(UpdateKeyWordDto updateKeyWordDto) async {
    final currentState = state;
    if (currentState is KeyWordsLoaded) {
      await _keywordRepository.updateKeyWord(updateKeyWordDto);
    }
  }

  Future<void> deleteKeyWordById(int id) async {
    final currentState = state;
    if (currentState is KeyWordsLoaded) {
      await _keywordRepository.deleteKeyWordById(id);
    }
  }
}
