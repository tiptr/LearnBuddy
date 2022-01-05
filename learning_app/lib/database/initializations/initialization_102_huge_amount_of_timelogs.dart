import 'package:drift/drift.dart';
import 'package:learning_app/features/tasks/persistence/task_keywords_dao.dart';
import 'package:learning_app/features/time_logs/persistence/time_logs_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';

/// Initialization of database entries: massive set of timelogs
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization102HugeAmountOfTimeLogs() async {
  final TimeLogsDao _dao = getIt<TimeLogsDao>();

  final List<TimeLogsCompanion> timeLogsList = [];

  const int existingTasksCount = 5000;
  const int maxNumberOfTimeLogsPerTask = 10;

  final now = DateTime.now();

  int currentId = 0;

  // Top Level Tasks:
  for (int i = 0; i < existingTasksCount; i++) {
    final numTimeLogs = i % (maxNumberOfTimeLogsPerTask + 1);

    for (int j = 0; j < numTimeLogs; j++) {
      timeLogsList.add(TimeLogsCompanion.insert(
        id: Value(currentId++),
        taskId: i,
        beginDateTime: now.subtract(Duration(days: i)),
        duration: Duration(minutes: i),
      ));
    }
  }

  await _dao.batch((batch) {
    batch.insertAll(_dao.timeLogs, timeLogsList);
  });
}
