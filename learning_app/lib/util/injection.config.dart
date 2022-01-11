// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../database/database.dart' as _i5;
import '../features/categories/persistence/categories_dao.dart' as _i22;
import '../features/categories/repositories/category_repository.dart' as _i3;
import '../features/categories/repositories/db_category_repository.dart' as _i4;
import '../features/keywords/persistence/keywords_dao.dart' as _i6;
import '../features/learn_lists/learn_lists_body_list/persistence/body_list_word_details_dao.dart'
    as _i21;
import '../features/learn_lists/learn_lists_general/persistence/learn_list_words_dao.dart'
    as _i9;
import '../features/learn_lists/learn_lists_general/persistence/learn_lists_dao.dart'
    as _i10;
import '../features/learn_lists/learn_lists_general/repositories/db_learn_list_repository.dart'
    as _i8;
import '../features/learn_lists/learn_lists_general/repositories/learn_list_repository.dart'
    as _i7;
import '../features/leisure/persistence/leisure_activities_dao.dart' as _i11;
import '../features/leisure/persistence/leisure_categories_dao.dart' as _i12;
import '../features/task_queue/persistence/task_queue_elements_dao.dart'
    as _i15;
import '../features/tasks/persistence/task_keywords_dao.dart' as _i13;
import '../features/tasks/persistence/task_learn_lists_dao.dart' as _i14;
import '../features/tasks/persistence/tasks_dao.dart' as _i18;
import '../features/tasks/repositories/db_task_repository.dart' as _i17;
import '../features/tasks/repositories/task_repository.dart' as _i16;
import '../features/time_logs/persistence/time_logs_dao.dart' as _i20;
import '../features/time_logs/repository/test_time_logging_repository.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CategoryRepository>(() => _i4.DbCategoryRepository());
  gh.singleton<_i5.Database>(_i5.Database());
  gh.singleton<_i6.KeyWordsDao>(_i6.KeyWordsDao(get<_i5.Database>()));
  gh.factory<_i7.LearnListRepository>(() => _i8.DbLearnListRepository());
  gh.singleton<_i9.LearnListWordsDao>(
      _i9.LearnListWordsDao(get<_i5.Database>()));
  gh.singleton<_i10.LearnListsDao>(_i10.LearnListsDao(get<_i5.Database>()));
  gh.singleton<_i11.LeisureActivitiesDao>(
      _i11.LeisureActivitiesDao(get<_i5.Database>()));
  gh.singleton<_i12.LeisureCategoriesDao>(
      _i12.LeisureCategoriesDao(get<_i5.Database>()));
  gh.singleton<_i13.TaskKeywordsDao>(_i13.TaskKeywordsDao(get<_i5.Database>()));
  gh.singleton<_i14.TaskLearnListsDao>(
      _i14.TaskLearnListsDao(get<_i5.Database>()));
  gh.singleton<_i15.TaskQueueElementsDao>(
      _i15.TaskQueueElementsDao(get<_i5.Database>()));
  gh.factory<_i16.TaskRepository>(() => _i17.DbTaskRepository());
  gh.singleton<_i18.TasksDao>(_i18.TasksDao(get<_i5.Database>()));
  gh.factory<_i19.TestTimeLogRepo>(() => _i19.TestTimeLogRepo());
  gh.singleton<_i20.TimeLogsDao>(_i20.TimeLogsDao(get<_i5.Database>()));
  gh.singleton<_i21.BodyListWordDetailsDao>(
      _i21.BodyListWordDetailsDao(get<_i5.Database>()));
  gh.singleton<_i22.CategoriesDao>(_i22.CategoriesDao(get<_i5.Database>()));
  return get;
}
