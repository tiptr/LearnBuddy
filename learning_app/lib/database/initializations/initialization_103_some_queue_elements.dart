import 'dart:math';

import 'package:drift/drift.dart';
import 'package:learning_app/features/tasks/persistence/task_queue_elements_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';

/// Initialization of database entries: queue elements
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization103QueueElements() async {
  final TaskQueueElementsDao _dao = getIt<TaskQueueElementsDao>();

  const int existingTopLevelTasksCount = 1000;
  const int numberOfQueueElements = 10;

  final now = DateTime.now();
  final List<TaskQueueElementsCompanion> queueElements = [];
  final List<int> usedTaskIds = [];

  for (int i = 0; i < numberOfQueueElements; i++) {
    final taskId =
        Random().nextInt((existingTopLevelTasksCount / 3).floor()) * 3;
    if (usedTaskIds.contains(taskId)) {
      continue;
    }
    usedTaskIds.add(taskId);

    queueElements.add(TaskQueueElementsCompanion.insert(
      taskId: Value(taskId),
      addedToQueueDateTime: now.subtract(Duration(days: Random().nextInt(80))),
      orderPlacement: i,
    ));
  }
  const taskId = 2;
  if (!usedTaskIds.contains(taskId)) {
    usedTaskIds.add(taskId);

    queueElements.add(TaskQueueElementsCompanion.insert(
      taskId: const Value(taskId),
      addedToQueueDateTime: now.subtract(Duration(days: Random().nextInt(80))),
      orderPlacement: numberOfQueueElements + 1,
    ));
  }

  await _dao.batch((batch) {
    batch.insertAll(_dao.taskQueueElements, queueElements);
  });
}
