import 'package:drift/drift.dart';
import 'package:learning_app/features/tasks/persistence/task_keywords_dao.dart';
import 'package:learning_app/util/injection.dart';
import '../database.dart';

/// Initialization of database entries: massive set of task keywords
///
/// This file is called from inside database.dart. Future initialization scripts
/// have to be explicitly added there, too.
Future<void> initialization101HugeAmountOfTaskKeywords() async {
  final TaskKeywordsDao _dao = getIt<TaskKeywordsDao>();

  final List<TaskKeywordsCompanion> taskKeywordsList = [];

  const int existingTasksCount = 5000;
  const int existingKeyWordsCount = 4;

  // Top Level Tasks:
  for (int i = 0; i < existingTasksCount; i++) {
    final numKeyWords = i % (existingKeyWordsCount + 1);

    for (int j = 0; j < numKeyWords; j++) {
      taskKeywordsList.add(TaskKeywordsCompanion(
        taskId: Value(i),
        keywordId: Value(j),
      ));
    }
  }

  // Batch insert, no awaits required inside
  await _dao.batch((batch) {
    batch.insertAll(_dao.taskKeywords, taskKeywordsList);
  });
}
