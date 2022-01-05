import 'package:learning_app/services/time_logging/dtos/time_log_dto.dart';
import 'package:learning_app/services/time_logging/models/time_log.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TimeLoggingRepository {
  Future<List<TimeLog>> loadTimeLogs();

  Future<TimeLog> createTimeLog(TimeLogDto dto);

  Future<bool> update(int id, TimeLogDto dto);
}
