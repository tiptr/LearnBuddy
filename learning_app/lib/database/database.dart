import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/initializations/initialization_003_leisure_categories.dart';
import 'package:learning_app/database/initializations/initialization_004_leisure_activities.dart';
import 'package:learning_app/database/initializations/initialization_100_huge_amount_of_tasks.dart';
import 'package:learning_app/database/type_converters/body_parts_converter.dart';
import 'package:learning_app/database/type_converters/color_converter.dart';
import 'package:learning_app/database/type_converters/learn_methods_converter.dart';
import 'package:learning_app/features/keywords/persistence/keywords_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_list_words_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_lists_dao.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_parts.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/persistence/body_list_word_details_dao.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/features/leisure/persistence/leisure_categories_dao.dart';
import 'package:learning_app/features/task_queue/persistence/task_queue_elements_dao.dart';
import 'package:learning_app/features/tasks/persistence/task_keywords_dao.dart';
import 'package:learning_app/features/tasks/persistence/task_learn_lists_dao.dart';
import 'package:learning_app/features/time_logs/persistence/time_logs_dao.dart';
import 'package:learning_app/util/storage_services.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/native.dart';
import 'package:learning_app/constants/storage_constants.dart';

// DAOs used to structure the database queries access
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/features/categories/persistence/categories_dao.dart';

// Converters
import 'package:learning_app/database/type_converters/duration_converter.dart';

// Also import all used models, as they are required in the generated extension file
// import 'package:learning_app/features/tasks/models/task.dart';
// import 'package:learning_app/features/categories/models/category.dart';

// Initialization scripts:
import 'initializations/initialization_001_categories.dart';
import 'initializations/initialization_002_keywords.dart';

// Migration scripts:

import 'initializations/initialization_101_huge_amount_of_task_keywords.dart';
import 'initializations/initialization_102_huge_amount_of_timelogs.dart';
import 'initializations/initialization_103_some_queue_elements.dart';
import 'migrations/v01_to_v02_migration.dart';
import 'migrations/v02_to_v03_migration.dart';

// The generated file:
// This will give an error at first,
// but it's needed for drift to know about the generated code
part 'database.g.dart';

// Toggle to activate / deactivate the demo-data generation at startup
const insertDemoDataAtFirstStartup = false;

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final Directory dbFolder = appStorageDirectory;

    final file = File(p.join(dbFolder.path, databaseName));
    return NativeDatabase(file);
  });
}

@singleton // Injectable via dependency injection
@DriftDatabase(
  daos: [
    BodyListWordDetailsDao,
    LearnListWordsDao,
    LearnListsDao,
    TaskLearnListsDao,
    LeisureCategoriesDao,
    LeisureActivitiesDao,
    TasksDao,
    TaskQueueElementsDao,
    CategoriesDao,
    TaskKeywordsDao,
    KeyWordsDao,
    TimeLogsDao,
  ],
  // Include all drift files containing the entity definitions and queries
  include: {
    'package:learning_app/features/tasks/persistence/tasks.drift',
    'package:learning_app/features/tasks/persistence/task_keywords.drift',
    'package:learning_app/features/tasks/persistence/task_learn_lists.drift',
    'package:learning_app/features/categories/persistence/categories.drift',
    'package:learning_app/features/keywords/persistence/keywords.drift',
    'package:learning_app/features/time_logs/persistence/time_logs.drift',
    'package:learning_app/features/task_queue/persistence/task_queue_elements.drift',
    'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_lists.drift',
    'package:learning_app/features/learn_lists/learn_lists_general/persistence/learn_list_words.drift',
    'package:learning_app/features/learn_lists/learn_lists_body_list/persistence/body_list_word_details.drift',
    'package:learning_app/features/leisure/persistence/leisure_categories.drift',
    'package:learning_app/features/leisure/persistence/leisure_activities.drift',
  },
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
          await initialization001Categories();
          await initialization002Keywords();
          await initialization003LeisureCategories();
          await initialization004LeisureActivities();

          if (insertDemoDataAtFirstStartup) {
            await initialization100HugeAmountOfTasks();
            await initialization101HugeAmountOfTaskKeywords();
            await initialization102HugeAmountOfTimeLogs();
            await initialization103QueueElements();
          }
        }
      },
    );
  }
}
