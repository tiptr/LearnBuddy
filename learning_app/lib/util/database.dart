import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

// DAOs used to structure the database queries access
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';

// Also import all used models, as they are required in the generated extension file
import 'package:learning_app/features/tasks/models/task.dart';

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
    final file = File(p.join(dbFolder.path, 'learning_app_db.sqlite'));
    return NativeDatabase(file);
  });
}

@singleton // Injectable via dependency injection
@DriftDatabase(
  daos: [TasksDao],
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
        if (from == 1) {
          // In the future, this can be used to perform migrations between
          // previous versions of the database and the current one

          // TODO: consider moving this to another file(s)

          // Example code:
          // await m.addColumn(todos, todos.targetDate);
        }
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
          // This is called on a fresh installation, when the database is not yet
          // present and after the schema has been created.

          // This is where insert statements for e.g. some
          // predefined categories would go.

          // Example code for inspiration:
          // final workId = await into(categories)
          //     .insert(const CategoriesCompanion(description: Value('Work')));
          //
          // await into(todos).insert(TodosCompanion(
          //   content: const Value('A first todo entry'),
          //   targetDate: Value(DateTime.now()),
          // ));
          //
          // await into(todos).insert(
          //   TodosCompanion(
          //     content: const Value('Rework persistence code'),
          //     category: Value(workId),
          //     targetDate: Value(
          //       DateTime.now().add(const Duration(days: 4)),
          //     ),
          //   ),
          // );
        }
      },
    );
  }
}
