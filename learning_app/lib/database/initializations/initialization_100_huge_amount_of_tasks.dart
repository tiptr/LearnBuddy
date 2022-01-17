import 'package:drift/drift.dart';
import 'dart:math';
import 'package:learning_app/util/injection.dart';
import '../database.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';

/// Initialization of database entries: massive set of tasks
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization100HugeAmountOfTasks() async {
  final TasksDao _dao = getIt<TasksDao>();

  final List<TasksCompanion> tasksList = [];

  final now = DateTime.now();

  const testDescription =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  int i = 0;

  const int topLevelCount = 1000;
  const int subLevelCount = 3000;
  const int subSubLevelCount = 5000;

  // Top Level Tasks:
  for (; i < topLevelCount; i++) {
    tasksList.add(TasksCompanion.insert(
      id: Value(i),
      title: (i % 4 != 0)
          ? '$i Top-Level Aufgabe'
          : '$i Top-Level Aufgabe mit langem Titel um die richtige Anzeige zu testen. Wird dies richtig angezeigt?',
      doneDateTime: (i % 3 == 0)
          ? const Value.absent()
          : Value(now.subtract(Duration(days: i))),
      description:
          (i % 2 == 0) ? const Value(testDescription) : const Value.absent(),
      categoryId: (i % 17 == 0) ? const Value.absent() : Value(i % 4),
      estimatedTime:
          (i % 3 == 0) ? Value(Duration(minutes: i)) : const Value.absent(),
      dueDate: (i % ((topLevelCount / 10).round()) == 0)
          ? const Value.absent()
          : Value(now.subtract(Duration(days: Random().nextInt(80) - 75))),
      creationDateTime: now.subtract(Duration(days: i)),
      parentTaskId: const Value.absent(),
      manualTimeEffortDelta:
          (i % 4 != 0) ? Duration(minutes: i) : const Duration(),
    ));
  }

  // Subtasks
  for (i = topLevelCount; i < subLevelCount + topLevelCount; i++) {
    final parentId = (i % (topLevelCount * 0.75)).floor();

    tasksList.add(TasksCompanion.insert(
      id: Value(i),
      title: (i % 4 != 0)
          ? '$i Sub-Aufgabe von $parentId'
          : '$i Sub-Aufgabe von $parentId mit langem Titel um die richtige Anzeige zu testen. Wird dies richtig angezeigt?',
      doneDateTime: (i % 3 == 0)
          ? const Value.absent()
          : Value(now.subtract(Duration(days: i))),
      description:
          (i % 2 == 0) ? const Value(testDescription) : const Value.absent(),
      categoryId: tasksList[parentId].categoryId,
      estimatedTime:
          (i % 3 != 0) ? Value(Duration(minutes: i)) : const Value.absent(),
      dueDate: (i % 3 == 0)
          ? tasksList[parentId].dueDate
          : (tasksList[parentId].dueDate.value == null
              ? const Value.absent()
              : Value(tasksList[parentId]
                  .dueDate
                  .value
                  ?.subtract(const Duration(days: 1)))),
      creationDateTime: now.subtract(Duration(days: i)),
      parentTaskId: Value(parentId),
      manualTimeEffortDelta:
          (i % 4 != 0) ? Duration(minutes: i) : const Duration(),
    ));
  }

  // Sub-Subtasks
  for (i = subLevelCount + topLevelCount;
      i < subSubLevelCount + subLevelCount + topLevelCount;
      i++) {
    final parentId =
        Random().nextInt(subLevelCount - 1).floor() + topLevelCount;

    final topLevelParentId =
        tasksList.firstWhere((task) => task.id.value == parentId).parentTaskId;

    tasksList.add(TasksCompanion.insert(
      id: Value(i),
      title: (i % 4 != 0)
          ? '$i Sub-Sub-Aufgabe von $topLevelParentId'
          : '$i Sub-Sub-Aufgabe von $topLevelParentId mit langem Titel um die richtige Anzeige zu testen. Wird dies richtig angezeigt?',
      doneDateTime: (i % 3 == 0)
          ? const Value.absent()
          : Value(now.subtract(Duration(days: i))),
      description:
          (i % 2 == 0) ? const Value(testDescription) : const Value.absent(),
      categoryId: tasksList[parentId].categoryId,
      estimatedTime:
          (i % 3 != 0) ? Value(Duration(minutes: i)) : const Value.absent(),
      dueDate: (i % 3 == 0)
          ? tasksList[parentId].dueDate
          : (tasksList[parentId].dueDate.value == null
              ? const Value.absent()
              : Value(tasksList[parentId]
                  .dueDate
                  .value
                  ?.subtract(const Duration(days: 1)))),
      creationDateTime: now.subtract(Duration(days: i)),
      parentTaskId: Value(parentId),
      manualTimeEffortDelta:
          (i % 4 != 0) ? Duration(minutes: i) : const Duration(),
    ));
  }

  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.tasks, tasksList);
  });
}
