import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskQueueListTile extends StatelessWidget {
  final TaskWithQueueStatus topLevelTaskWithQueueStatus;

  const TaskQueueListTile({required this.topLevelTaskWithQueueStatus, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeLoggingBloc bloc;
    bloc = context.read<TimeLoggingBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topLevelTask(bloc),
        Container(
          padding: const EdgeInsets.only(left: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: topLevelTaskWithQueueStatus.task.category?.color ?? Colors.grey,
                width: 8,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (Task child in topLevelTaskWithQueueStatus.task.children) Subtask(child, topLevelTaskWithQueueStatus.task, bloc, 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget topLevelTask(bloc) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text(
              topLevelTaskWithQueueStatus.task.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onTap: () {
              bloc.add(AddTimeLoggingObjectEvent(topLevelTaskWithQueueStatus.task.id, topLevelTaskWithQueueStatus.task.id));
            },
          ),
        ),
      ],
    );
  }
}

class Subtask extends StatelessWidget {
  final Task task;
  final Task topLevelTask;
  final TimeLoggingBloc bloc;

  final int level;


  const Subtask(this.task, this.topLevelTask, this.bloc, this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: ListTile(
            title: Text(
              task.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Text(level.toString()),
            onTap: () {
              bloc.add(AddTimeLoggingObjectEvent(task.id, topLevelTask.id));
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: topLevelTask.category?.color ?? Colors.grey,
                width: 8,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (Task child in task.children) Subtask(child, topLevelTask, bloc, level + 1),
            ],
          ),
        )
      ],
    );
  }
}
