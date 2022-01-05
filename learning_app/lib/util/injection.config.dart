// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../database/database.dart' as _i5;
import '../features/categories/persistence/categories_dao.dart' as _i9;
import '../features/categories/repositories/category_repository.dart' as _i3;
import '../features/categories/repositories/db_category_repository.dart' as _i4;
import '../features/tasks/persistence/tasks_dao.dart' as _i8;
import '../features/tasks/repositories/db_task_repository.dart' as _i7;
import '../features/tasks/repositories/task_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CategoryRepository>(() => _i4.DbCategoryRepository());
  gh.singleton<_i5.Database>(_i5.Database());
  gh.factory<_i6.TaskRepository>(() => _i7.DbTaskRepository());
  gh.singleton<_i8.TasksDao>(_i8.TasksDao(get<_i5.Database>()));
  gh.singleton<_i9.CategoriesDao>(_i9.CategoriesDao(get<_i5.Database>()));
  return get;
}
