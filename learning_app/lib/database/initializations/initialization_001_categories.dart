import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';

/// Initialization of database entries: categories
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization001Categories() async {
  final CategoriesDao _dao = getIt<CategoriesDao>();
  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.categories, [
      CategoriesCompanion.insert(
        id: const Value(0),
        name: 'Englisch',
        color: const Color(0xFFBF5252),
      ),
      CategoriesCompanion.insert(
        id: const Value(1),
        name: 'Geschichte',
        color: const Color(0xFF4775CC),
      ),
      CategoriesCompanion.insert(
        id: const Value(2),
        name: 'Mathe',
        color: const Color(0xFFE77420),
      ),
      CategoriesCompanion.insert(
        id: const Value(3),
        name: 'Freizeit',
        color: const Color(0xFF6A9F19),
      ),
    ]);
  });
}
