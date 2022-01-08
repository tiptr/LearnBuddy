// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../database/database.dart' as _i5;
import '../features/categories/persistence/categories_dao.dart' as _i19;
import '../features/categories/repositories/category_repository.dart' as _i3;
import '../features/categories/repositories/db_category_repository.dart' as _i4;
import '../features/keywords/persistence/keywords_dao.dart' as _i6;
import '../features/learning_aids/persistence/learn_list_words_dao.dart' as _i7;
import '../features/learning_aids/persistence/learn_lists_dao.dart' as _i8;
import '../features/learning_aids_body_list/persistence/body_list_word_details_dao.dart'
    as _i18;
import '../features/leisure/persistence/leisure_activities_dao.dart' as _i9;
import '../features/leisure/persistence/leisure_categories_dao.dart' as _i10;
import '../features/task_queue/persistence/task_queue_elements_dao.dart'
    as _i13;
import '../features/tasks/persistence/task_keywords_dao.dart' as _i11;
import '../features/tasks/persistence/task_learn_lists_dao.dart' as _i12;
import '../features/tasks/persistence/tasks_dao.dart' as _i16;
import '../features/tasks/repositories/db_task_repository.dart' as _i15;
import '../features/tasks/repositories/task_repository.dart' as _i14;
import '../features/time_logs/persistence/time_logs_dao.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CategoryRepository>(() => _i4.DbCategoryRepository());
  gh.singleton<_i5.Database>(_i5.Database());
  gh.singleton<_i6.KeyWordsDao>(_i6.KeyWordsDao(get<_i5.Database>()));
  gh.singleton<_i7.LearnListWordsDao>(
      _i7.LearnListWordsDao(get<_i5.Database>()));
  gh.singleton<_i8.LearnListsDao>(_i8.LearnListsDao(get<_i5.Database>()));
  gh.singleton<_i9.LeisureActivitiesDao>(
      _i9.LeisureActivitiesDao(get<_i5.Database>()));
  gh.singleton<_i10.LeisureCategoriesDao>(
      _i10.LeisureCategoriesDao(get<_i5.Database>()));
  gh.singleton<_i11.TaskKeywordsDao>(_i11.TaskKeywordsDao(get<_i5.Database>()));
  gh.singleton<_i12.TaskLearnListsDao>(
      _i12.TaskLearnListsDao(get<_i5.Database>()));
  gh.singleton<_i13.TaskQueueElementsDao>(
      _i13.TaskQueueElementsDao(get<_i5.Database>()));
  gh.factory<_i14.TaskRepository>(() => _i15.DbTaskRepository());
  gh.singleton<_i16.TasksDao>(_i16.TasksDao(get<_i5.Database>()));
  gh.singleton<_i17.TimeLogsDao>(_i17.TimeLogsDao(get<_i5.Database>()));
  gh.singleton<_i18.BodyListWordDetailsDao>(
      _i18.BodyListWordDetailsDao(get<_i5.Database>()));
  gh.singleton<_i19.CategoriesDao>(_i19.CategoriesDao(get<_i5.Database>()));
  return get;
}
