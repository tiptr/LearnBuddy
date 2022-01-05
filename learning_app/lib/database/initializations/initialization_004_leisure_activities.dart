import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';

/// Initialization of database entries: leisure activities
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization004LeisureActivities() async {
  final LeisureActivitiesDao _dao = getIt<LeisureActivitiesDao>();
  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.leisureActivities, [
      LeisureActivitiesCompanion.insert(
        id: const Value(0),
        leisureCategoryId: 0,
        name: 'Grinsende Katzen',
        duration: const Duration(minutes: 10),
        descriptionShort:
            'Zeichne auf einem Papier fünf Katzen mit verschiedenen menschlichen Gesichtsausdrücken.\n Teilt die Bilder innerhalb eurer Klasse und identifiziert euren Picasso.',
        isFavorite: false,
      ),
    ]);
  });
}
