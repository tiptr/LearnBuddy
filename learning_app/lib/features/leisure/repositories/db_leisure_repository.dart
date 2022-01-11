import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/persistence/leisure_activities_dao.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_ordering.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/database/database.dart' as db;

/// Concrete repository implementation using the database with drift
@Injectable(as: LeisureRepository)
class DbLeisureRepository implements LeisureRepository {
  @override
  Future<bool> toggleFavorite(int activityId, bool favorite) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Stream<List<LeisureCategory>> watchLeisureCategories() {
    // TODO: implement watchLeisureCategories
    throw UnimplementedError();
  }
  // load the data access object (with generated entities and queries) via dependency inj.
  // final LeisureActivitiesDao _dao = getIt<TasksDao>();
  // final LeisureActivitiesDao _dao = getIt<TasksDao>();
  //
  // Stream<List<LeisureCategory>> watchLeisureCategories({
  //   int? limit,
  //   int? offset,
  //   TaskFilter taskFilter,
  //   TaskOrder taskOrder,
  // });
  //
  // Future<bool> toggleFavorite(int activityId, bool favorite);
}
