import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/database/database.dart';

// Also import the used model(s), as they are required in the generated extension file
import 'package:learning_app/features/tasks/models/task.dart';

part 'tasks_dao.g.dart';

/// Data access object to structure all related queries
///
/// This is not strictly required, but helps structuring the project. Without the
/// definition of DAOs, all queries would be accessible directly through the Database.
/// The _TodosDaoMixin will be created by drift. It contains all the necessary
/// fields for the tables. The <MyDatabase> type annotation is the database class
/// that should use this dao.
@singleton // Injectable via dependency injection
@DriftAccessor(
  // Include the drift file containing the entity definitions and queries
  include: {'package:learning_app/features/tasks/persistence/tasks.drift'},
)
class TasksDao extends DatabaseAccessor<Database> with _$TasksDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  TasksDao(Database db) : super(db);
}