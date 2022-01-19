import 'package:drift/drift.dart';
import 'package:learning_app/features/leisure/persistence/leisure_categories_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';

/// Initialization of database entries: leisure categories
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization003LeisureCategories() async {
  final LeisureCategoriesDao _dao = getIt<LeisureCategoriesDao>();
  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.leisureCategories, [
      LeisureCategoriesCompanion.insert(
        id: const Value(0),
        name: 'Fun Challenges',
        pathToImage: const Value('assets/leisure/leisure-group-fun.svg'),
      ),
      LeisureCategoriesCompanion.insert(
        id: const Value(1),
        name: 'Fitness ohne Geräte',
        pathToImage: const Value('assets/leisure/leisure-group-fitness.svg'),
      ),
      LeisureCategoriesCompanion.insert(
        id: const Value(2),
        name: 'Yoga & Meditation',
        pathToImage: const Value('assets/leisure/leisure-group-yoga.svg'),
      ),
      LeisureCategoriesCompanion.insert(
        id: const Value(3),
        name: 'Outdoor & Bewegung',
        pathToImage: const Value('assets/leisure/leisure-group-outdoor.svg'),
      ),
      LeisureCategoriesCompanion.insert(
        id: const Value(4),
        name: 'Weitere Vorschäge',
        pathToImage: const Value('assets/leisure/leisure-group-further.svg'),
      ),
    ]);
  });
}
