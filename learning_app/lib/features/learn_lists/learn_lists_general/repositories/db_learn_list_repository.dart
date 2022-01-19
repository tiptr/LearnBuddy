import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/database/database.dart' as db;
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list_learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/persistence/body_list_word_details_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/create_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_list_words_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_lists_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:rxdart/rxdart.dart';

/// Concrete repositories implementation using the database with drift
@Injectable(as: LearnListRepository)
class DbLearnListRepository implements LearnListRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final LearnListsDao _learnListDao = getIt<LearnListsDao>();
  final LearnListWordsDao _learnListWordsDao = getIt<LearnListWordsDao>();
  final BodyListWordDetailsDao _bodyListWordDetailsDao =
      getIt<BodyListWordDetailsDao>();
  final CategoriesDao _categoriesDao = getIt<CategoriesDao>();

  Stream<List<LearnList>>? _learnListStream;
  Stream<Map<int, LearnList>>? _idToLearnListMapStream;

  // TODO: later include (optional) sorting and filters (e.g. archived)
  // TODO: but make the default 'not filtered', since the task list depends on it
  @override
  Stream<List<LearnList>> watchLearnLists() {
    _learnListStream = _learnListStream ?? (_buildListStream());
    return _learnListStream as Stream<List<LearnList>>;
  }

  @override

  /// Returns a stream of maps that associate the learn-list-id with the list
  ///
  /// There only ever will exist one of this streams in parallel.
  Stream<Map<int, LearnList>> watchIdToLearnListMap() {
    _idToLearnListMapStream =
        (_idToLearnListMapStream ?? (_createIdToLearnListMapStream()));

    return _idToLearnListMapStream as Stream<Map<int, LearnList>>;
  }

  /// Creates a stream of maps that associate the learn-list-id with the list
  Stream<Map<int, LearnList>> _createIdToLearnListMapStream() {
    final Stream<List<LearnList>> learnListsStream = watchLearnLists();
    return learnListsStream.map((models) {
      final idToModel = <int, LearnList>{};
      for (var model in models) {
        idToModel.putIfAbsent(model.id, () => model);
      }
      return idToModel;
    });
  }

  /// Actually creates the stream. To be called only once.
  Stream<List<LearnList>> _buildListStream() {
    final Stream<List<LearnListEntity>> learnListEntitiesStream =
        _learnListDao.watchLearnListEntities();

    final Stream<List<LearnListWordEntity>> learnListWordEntitiesStream =
        _learnListWordsDao.watchLearnListWordEntities();

    final Stream<List<BodyListWordDetailEntity>>
        bodyListWordDetailEntitiesStream =
        _bodyListWordDetailsDao.watchBodyListWordDetailEntities();

    final Stream<Map<int, Category>> idToCategoryMapStream =
        _categoriesDao.watchIdToCategoryMap();

    // This will be called whenever the learn lists change:
    return idToCategoryMapStream.switchMap((idToCategoryMap) {
      // This will be called whenever the learn lists change:
      return learnListEntitiesStream.switchMap((learnLists) {
        // Merge it all together and build a stream of task-models
        return learnListWordEntitiesStream.switchMap((words) {
          // Create a map to efficiently allocate the words by their parent list
          // this maps are generated as low in the stream-chain as possible, so
          // they will not have to be created at every update in the inner chain
          final listIdToWordsMap = _createListIdToWordsMap(words);

          // This will be called whenever the body list word details change:
          return bodyListWordDetailEntitiesStream.map((bodyWordDetails) {
            final wordIdToBodyDetailsMap =
                _createWordIdToBodyDetailsMap(bodyWordDetails);

            return _mergeEntitiesTogether(
              learnLists: learnLists,
              listIdToWordsMap: listIdToWordsMap,
              wordIdToBodyDetailsMap: wordIdToBodyDetailsMap,
              idToCategoryMap: idToCategoryMap,
            );
          });
        });
      });
    });
  }

  /// Creates a map that allocates all linked words for each learn list
  Map<int, List<LearnListWordEntity>> _createListIdToWordsMap(
    List<LearnListWordEntity> words,
  ) {
    final idToEntityList = <int, List<LearnListWordEntity>>{};
    for (var entity in words) {
      idToEntityList.putIfAbsent(entity.listId, () => []).add(entity);
    }
    return idToEntityList;
  }

  Map<int, BodyListWordDetailEntity> _createWordIdToBodyDetailsMap(
      List<BodyListWordDetailEntity> entities) {
    final idToEntity = <int, BodyListWordDetailEntity>{};
    for (var entity in entities) {
      idToEntity.putIfAbsent(entity.wordId, () => entity);
    }
    return idToEntity;
  }

  /// Create the list of learn lists by merging everything
  List<LearnList> _mergeEntitiesTogether(
      {required List<LearnListEntity> learnLists,
      required Map<int, List<LearnListWordEntity>> listIdToWordsMap,
      required Map<int, BodyListWordDetailEntity> wordIdToBodyDetailsMap,
      required Map<int, Category> idToCategoryMap}) {
    return learnLists.map((listEntity) {
      final LearnList listModel;
      switch (listEntity.learnMethod) {
        case LearnMethods.bodyList:
          final words = listIdToWordsMap[listEntity.id];
          final List<BodyListLearnListWord>? wordsWithDetails = words
              ?.map((wordEntity) => BodyListLearnListWord(
                    id: wordEntity.id,
                    word: wordEntity.word,
                    bodyPart: wordIdToBodyDetailsMap[wordEntity.id]?.bodyPart,
                    association:
                        wordIdToBodyDetailsMap[wordEntity.id]?.association,
                  ))
              .toList();

          listModel = BodyList(
            id: listEntity.id,
            name: listEntity.name,
            creationDate: listEntity.creationDateTime,
            words: wordsWithDetails ?? [],
            category: idToCategoryMap[listEntity.categoryId],
            isArchived: listEntity.isArchived,
          );
          break;
        case LearnMethods.storyList:
          // TODO: Handle this case when implementing the story list.
          throw UnimplementedError();
        case LearnMethods.simpleLearnList:
          final wordEntities = listIdToWordsMap[listEntity.id];
          final List<LearnListWord>? wordModels = wordEntities
              ?.map((wordEntity) => LearnListWord(
                    id: wordEntity.id,
                    word: wordEntity.word,
                  ))
              .toList();

          listModel = LearnList(
            id: listEntity.id,
            name: listEntity.name,
            creationDate: listEntity.creationDateTime,
            words: wordModels ?? [],
            category: idToCategoryMap[listEntity.categoryId],
            isArchived: listEntity.isArchived,
          );

          break;
      }

      return listModel;
    }).toList();
  }

  @override
  Future<int> createLearnList(
      CreateLearnListDto newLearnList, LearnMethods method) async {
    assert(newLearnList.isReadyToStore);

    // Do the complete update in a transaction, so that the streams will only
    // update once, after the whole update is ready

    // Important: whenever using transactions, every (!) query / update / insert
    //            inside, has to be awaited -> data loss possible otherwise!
    return _learnListDao.transaction(() async {
      int newLearnListId = await _learnListDao.createLearnList(
        db.LearnListsCompanion(
            id: newLearnList.id,
            name: newLearnList.name,
            learnMethod: Value(method),
            categoryId: Value(newLearnList.category.value?.id),
            creationDateTime: Value(DateTime.now()),
            isArchived:
                const Value(false) //TODO: change for archive functionality
            ),
      );

      int i = 0;
      for (LearnListWord word in newLearnList.words.value) {
        await _learnListWordsDao.transaction(
          () async {
            int wordId = await _learnListWordsDao.createLearnListWord(
              db.LearnListWordsCompanion(
                id: Value(word.id),
                listId: Value(newLearnListId),
                orderPlacement: Value(i),
                word: Value(word.word), //TODO: change for archive functionality
              ),
            );

            if (method == LearnMethods.bodyList) {
              await _bodyListWordDetailsDao.transaction(
                () async {
                  await _bodyListWordDetailsDao.createBodyListWord(
                    db.BodyListWordDetailsCompanion(
                        wordId: Value(wordId),
                        bodyPart: const Value.absent(),
                        association: const Value.absent()),
                  );
                },
              );
            }
          },
        );
        i++;
      }

      return newLearnListId;
    });
  }
}
