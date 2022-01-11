import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/features/time_logs/dtos/time_log_dto.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';
import 'package:learning_app/features/time_logs/persistence/time_logs_dao.dart';
import 'package:learning_app/features/time_logs/repository/time_logging_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/database/database.dart' as db;

@Injectable(as: TimeLoggingRepository)
class DbTimeLoggingRepository implements TimeLoggingRepository {
  final TimeLogsDao _timeLogsDao = getIt<TimeLogsDao>();

  @override
  Future<TimeLog> createTimeLog(TimeLogDto dto) async{
    int id = await _timeLogsDao.createTimeLog(db.TimeLogsCompanion(
      beginDateTime: Value(dto.beginTime),
      duration: Value(dto.duration),
      taskId: Value(dto.taskId),
    ));
    return TimeLog(id: id, taskId: dto.taskId, beginTime: dto.beginTime, duration: dto.duration);
  }


  @override
  Future<bool> update(int id, TimeLogDto dto) async {
    int updated = await _timeLogsDao.updateTimeLog(id, dto.duration);
    return updated != 0;
  }

}