import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopLevelListTile extends StatelessWidget {
  final TaskWithQueueStatus topLevelTaskWithQueueStatus;

  const TopLevelListTile({required this.topLevelTaskWithQueueStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeLoggingBloc bloc;
    bloc = context.read<TimeLoggingBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            topLevelTaskWithQueueStatus.task.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          onTap: () {
            bloc.add(AddTimeLoggingObjectEvent(
                topLevelTaskWithQueueStatus.task.id,
                topLevelTaskWithQueueStatus.task.id));
          },
        ),
      ],
    );
  }
}

class SubtaskFullTile extends StatelessWidget {
  final TaskWithQueueStatus topLevelTaskWithQueueStatus;

  const SubtaskFullTile({required this.topLevelTaskWithQueueStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color:
                topLevelTaskWithQueueStatus.task.category?.color ?? Colors.grey,
            width: 8,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (Task child in topLevelTaskWithQueueStatus.task.children)
            SingleSubtask(child, topLevelTaskWithQueueStatus.task, 1),
        ],
      ),
    );
  }
}

class SingleSubtask extends StatelessWidget {
  final Task task;
  final Task topLevelTask;

  final int level;

  const SingleSubtask(this.task, this.topLevelTask, this.level, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
              for (Task child in task.children)
                SingleSubtask(child, topLevelTask, level + 1),
            ],
          ),
        )
      ],
    );
  }
}
