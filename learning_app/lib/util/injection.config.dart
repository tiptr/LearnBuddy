// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../database/database.dart' as _i3;
import '../features/tasks/persistence/tasks_dao.dart' as _i6;
import '../features/tasks/repositories/db_task_repository.dart' as _i5;
import '../features/tasks/repositories/task_repository.dart' as _i4;
import '../services/time_logging/repository/test_time_logging_repository.dart'
    as _i8;
import '../services/time_logging/repository/time_logging_repository.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.Database>(_i3.Database());
  gh.factory<_i4.TaskRepository>(() => _i5.DbTaskRepository());
  gh.singleton<_i6.TasksDao>(_i6.TasksDao(get<_i3.Database>()));
  gh.factory<_i7.TimeLoggingRepository>(() => _i8.TestTimeLogRepo());
  return get;
}
