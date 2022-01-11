import 'package:injectable/injectable.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';
import 'package:learning_app/services/time_logging/dtos/time_log_dto.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';

/// Concrete repository implementation using the database with drift
@Injectable(as: TimeLoggingRepository)
class TestTimeLogRepo implements TimeLoggingRepository {
  @override
  Future<TimeLog> createTimeLog(TimeLogDto dto) {
    return Future.delayed(
        const Duration(milliseconds: 2),
        () => TimeLog(
              id: 1,
              beginTime: dto.beginTime,
              duration: dto.duration,
              taskId: dto.taskId,
            ));
  }

  @override
  Future<List<TimeLog>> loadTimeLogs() {
    return Future.delayed(
        const Duration(milliseconds: 2),
        () => [
              TimeLog(
                id: 1,
                beginTime: DateTime.now(),
                duration: const Duration(hours: 2),
                taskId: 1,
              ),
              TimeLog(
                id: 2,
                beginTime: DateTime.now(),
                duration: const Duration(minutes: 3),
                taskId: 1,
              ),
              TimeLog(
                id: 3,
                beginTime: DateTime.now(),
                duration: const Duration(hours: 2),
                taskId: 2,
              ),
            ]);
  }

  @override
  Future<bool> update(int id, TimeLogDto dto) {
    return Future.delayed(const Duration(milliseconds: 2), () => true);
  }
  // load the data access object (with generated entities and queries) via dependency inj.

}
