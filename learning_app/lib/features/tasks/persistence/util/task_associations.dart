import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/tasks/models/queue_status.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

class TaskAssociations {
  final Map<int, Category> idToCategoryMap;
  final Map<int, List<KeyWord>> taskIdToKeywordsMap;
  final Map<int, List<TimeLog>> taskIdToTimeLogsMap;
  final Map<int, QueueStatus> taskIdToQueueStatusMap;
  final Map<int, List<LearnList>> taskIdToLearnListMap;

  const TaskAssociations({
    required this.idToCategoryMap,
    required this.taskIdToKeywordsMap,
    required this.taskIdToTimeLogsMap,
    required this.taskIdToQueueStatusMap,
    required this.taskIdToLearnListMap,
  });
}
