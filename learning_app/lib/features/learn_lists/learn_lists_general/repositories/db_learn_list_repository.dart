import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list_learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/persistence/body_list_word_details_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_list_words_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_lists_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:rxdart/src/transformers/switch_map.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: LearnListRepository)
class DbLearnListRepository implements LearnListRepository {
  // load the data access object (with generated entities and queries) via dependency inj.
  final LearnListsDao _learnListDao = getIt<LearnListsDao>();
  final LearnListWordsDao _learnListWordsDao = getIt<LearnListWordsDao>();
  final BodyListWordDetailsDao _bodyListWordDetailsDao =
  getIt<BodyListWordDetailsDao>();
  final CategoriesDao _categoriesDao = getIt<CategoriesDao>();

  Stream<List<LearnList>>? _learnListStream;

  // TODO: later include (optional) sorting and filters
  @override
  Stream<List<LearnList>> watchLearnLists() {
    _learnListStream = _learnListStream ?? (_buildListStream());
    return _learnListStream as Stream<List<LearnList>>;
  }

  // TODO: archived-filter!!

  /// Actually creates the stream. To be called only once.
  Stream<List<LearnList>> _buildListStream() {
    final Stream<List<LearnListEntity>> learnListEntitiesStream =
    _learnListDao.watchLearnListEntities();

    final Stream<List<LearnListWordEntity>> learnListWordEntitiesStream =
    _learnListWordsDao.watchLearnListWordEntities();

    final Stream<List<BodyListWordDetailEntity>>
    bodyListWordDetailEntitiesStream =
    _bodyListWordDetailsDao.watchBodyListWordDetailEntities();

    final Stream<Map<int, Category>>
    idToCategoryMapStream =
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
          final listIdToWordsMap = createListIdToWordsMap(words);

          // This will be called whenever the body list word details change:
          return bodyListWordDetailEntitiesStream.map((bodyWordDetails) {
            final wordIdToBodyDetailsMap =
            createWordIdToBodyDetailsMap(bodyWordDetails);

            return mergeEntitiesTogether(
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
  Map<int, List<LearnListWordEntity>> createListIdToWordsMap(
      List<LearnListWordEntity> words,) {
    final idToEntityList = <int, List<LearnListWordEntity>>{};
    for (var entity in words) {
      idToEntityList.putIfAbsent(entity.listId, () => []).add(entity);
    }
    return idToEntityList;
  }

  Map<int, BodyListWordDetailEntity> createWordIdToBodyDetailsMap(
      List<BodyListWordDetailEntity> entities) {
    final idToEntity = <int, BodyListWordDetailEntity>{};
    for (var entity in entities) {
      idToEntity.putIfAbsent(entity.wordId, () => entity);
    }
    return idToEntity;
  }

  /// Create the list of learn lists by merging everything
  List<LearnList> mergeEntitiesTogether(
      {required List<LearnListEntity> learnLists,
        required Map<int, List<LearnListWordEntity>> listIdToWordsMap,
        required Map<int, BodyListWordDetailEntity> wordIdToBodyDetailsMap,
        required Map<int, Category> idToCategoryMap}) {
    return learnLists.map((listEntity) {
      final LearnList listModel;
      switch (listEntity.learnMethod) {
        case LearnMethods.bodyList:
          final words = listIdToWordsMap[listEntity.id];
          final List<BodyListLearnListWord>? wordsWithDetails =
          words?.map((wordEntity) =>
              BodyListLearnListWord(
                id: wordEntity.id,
                word: wordEntity.word,
                bodyPart: wordIdToBodyDetailsMap[wordEntity.id]?.bodyPart,
                association: wordIdToBodyDetailsMap[wordEntity.id]?.association,
              )).toList();

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
          break;
      }

      return listModel;
    }).toList();
  }
}
