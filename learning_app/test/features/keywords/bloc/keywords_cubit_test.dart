import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/dtos/create_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/keywords/dtos/update_key_word_dto.dart';
import 'package:learning_app/features/keywords/repositories/keyword_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockKeyWordsRepository extends Mock implements KeyWordsRepository {}

class AnyCreateKeyWordDto extends Mock implements CreateKeyWordDto {}

class AnyUpdateKeyWordDto extends Mock implements UpdateKeyWordDto {}

void main() {
  late MockKeyWordsRepository mockKeyWordsRepository;
  late KeyWordsCubit keyWordsCubit;

  ReadKeyWordDto mockKeyWord = const ReadKeyWordDto(
    id: 1,
    name: "Mock KeyWord",
  );

  CreateKeyWordDto mockCreateDto = const CreateKeyWordDto(
    name: "New KeyWord",
  );

  UpdateKeyWordDto mockUpdateDto = const UpdateKeyWordDto(
    id: 1,
    name: "New KeyWord",
  );

  Stream<List<ReadKeyWordDto>> mockKeyWordStream = Stream.value([mockKeyWord]);

  setUp(() {
    mockKeyWordsRepository = MockKeyWordsRepository();
    keyWordsCubit = KeyWordsCubit(keywordRepository: mockKeyWordsRepository);
  });

  setUpAll(() {
    registerFallbackValue(AnyCreateKeyWordDto());
    registerFallbackValue(AnyUpdateKeyWordDto());
  });

  group(
    'when calling loadKeyWords',
    () {
      blocTest<KeyWordsCubit, KeyWordsState>(
        'KeyWordsCubit should fetch all keyWords and store the result stream',
        build: () {
          when(() => mockKeyWordsRepository.watchKeyWords())
              .thenAnswer((_) => mockKeyWordStream);

          return keyWordsCubit;
        },
        act: (cubit) async => await cubit.loadKeyWords(),
        expect: () => [
          KeyWordsLoading(),
          KeyWordsLoaded(keywordsStream: mockKeyWordStream),
        ],
        verify: (_) {
          verify(() => mockKeyWordsRepository.watchKeyWords()).called(1);
        },
      );
    },
  );

  group(
    'when calling createKeyWord',
    () {
      blocTest<KeyWordsCubit, KeyWordsState>(
        'KeyWordsCubit should create the keyword',
        build: () {
          when(() => mockKeyWordsRepository.createKeyWord(any()))
              .thenAnswer((_) => Future.value(1));
          return keyWordsCubit;
        },
        seed: () => KeyWordsLoaded(keywordsStream: Stream.value([])),
        act: (cubit) async => await cubit.createKeyWord(mockCreateDto),
        verify: (_) {
          verify(() => mockKeyWordsRepository.createKeyWord(mockCreateDto))
              .called(1);
        },
      );
    },
  );

  group(
    'when calling updateKeyWord',
    () {
      blocTest<KeyWordsCubit, KeyWordsState>(
        'KeyWordsCubit should update the keyword',
        build: () {
          when(() => mockKeyWordsRepository.updateKeyWord(any()))
              .thenAnswer((_) => Future.value(1));
          return keyWordsCubit;
        },
        seed: () => KeyWordsLoaded(keywordsStream: Stream.value([])),
        act: (cubit) async => await cubit.updateKeyWord(mockUpdateDto),
        verify: (_) {
          verify(() => mockKeyWordsRepository.updateKeyWord(mockUpdateDto))
              .called(1);
        },
      );
    },
  );

  group(
    'when calling deleteKeyWord',
    () {
      blocTest<KeyWordsCubit, KeyWordsState>(
        'KeyWordsCubit should delete the keyword',
        build: () {
          when(() => mockKeyWordsRepository.deleteKeyWordById(any()))
              .thenAnswer((_) => Future.value(true));
          return keyWordsCubit;
        },
        seed: () => KeyWordsLoaded(keywordsStream: Stream.value([])),
        act: (cubit) async => await cubit.deleteKeyWordById(1),
        verify: (_) {
          verify(() => mockKeyWordsRepository.deleteKeyWordById(1)).called(1);
        },
      );
    },
  );
}
