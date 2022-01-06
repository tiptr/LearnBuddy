import 'package:drift/drift.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/keywords/persistence/keywords_dao.dart';
import 'package:learning_app/util/injection.dart';

/// Initialization of database entries: keywords
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization002Keywords() async {
  final KeyWordsDao _dao = getIt<KeyWordsDao>();
  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.keywords, [
      KeywordsCompanion.insert(id: const Value(0), name: 'Hausaufgabe'),
      KeywordsCompanion.insert(id: const Value(1), name: 'Lernen'),
      KeywordsCompanion.insert(
          id: const Value(2), name: 'Prüfungsvorbereitung'),
      KeywordsCompanion.insert(id: const Value(3), name: 'Privat'),
    ]);
  });
}
