import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:learning_app/constants/database_constants.dart';

// DAOs used to structure the database queries access
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';

// Also import all used models, as they are required in the generated extension file
import 'package:learning_app/features/tasks/models/task.dart';

// Initialization scripts:
import 'initializations/initialization_01_category_colors.dart';
import 'initializations/initialization_02_categories.dart';

// Migration scripts:
import 'initializations/initialization_03_test_tasks.dart';
import 'migrations/v01_to_v02_migration.dart';
import 'migrations/v02_to_v03_migration.dart';

// The generated file:
// This will give an error at first,
// but it's needed for drift to know about the generated code
part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, databaseName));
    return NativeDatabase(file);
  });
}

@singleton // Injectable via dependency injection
@DriftDatabase(
  daos: [TasksDao],
  tables: [Tasks],
  // Include all drift files containing the entity definitions and queries
  include: {'package:learning_app/features/tasks/persistence/tasks.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        // This is called on a fresh installation, when the database is not yet
        // present and creates the schema.
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Execute all migrations scripts that are required to get from the
        // current to the latest version step by step
        if (from <= 1) {
          await migrateV01ToV02();
        }

        if (from <= 2) {
          await migrateV02ToV03();
        }
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
          // This is called on a fresh installation, when the database is not yet
          // present and after the schema has been created.

          // Call every initialization scripts that are implemented:
          await initialization01CategoryColors();
          await initialization02Categories();
          await initialization03TestTasks();
          //     .insert(const CategoriesCompanion(description: Value('Work')));
        }
      },
    );
  }
}
