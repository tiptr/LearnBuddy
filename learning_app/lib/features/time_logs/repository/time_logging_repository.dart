import 'package:learning_app/features/time_logs/dtos/time_log_dto.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

/// Repository interface to separate business logic from the persistence layer
abstract class TimeLoggingRepository {
  Future<TimeLog> createTimeLog(TimeLogDto dto);

  Future<bool> update(int id, TimeLogDto dto);
}
