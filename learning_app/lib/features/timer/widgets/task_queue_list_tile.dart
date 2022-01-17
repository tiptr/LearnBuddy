import 'package:flutter/material.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/util/logger.dart';

class TopLevelListTile extends StatelessWidget {
  final TaskWithQueueStatus topLevelTaskWithQueueStatus;

  const TopLevelListTile({required this.topLevelTaskWithQueueStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeLoggingBloc timeLogBloc = context.read<TimeLoggingBloc>();
    final TaskQueueBloc taskQueueBloc = context.read<TaskQueueBloc>();
    int? selectedTaskId;
    if (taskQueueBloc.state is TaskQueueReady) {
      final state = taskQueueBloc.state as TaskQueueReady;
      selectedTaskId = state.selectedTask;
    } else {
      logger.d("This state should not be accessible: queue not initialized");
    }

    return InkWell(
      child: Text(
        topLevelTaskWithQueueStatus.task.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: topLevelTaskWithQueueStatus.task.id == selectedTaskId
              ? Theme.of(context).colorScheme.primary
              : const Color(0xFF636573),
        ),
      ),
      onTap: () {
        taskQueueBloc
            .add(SelectQueuedTaskEvent(topLevelTaskWithQueueStatus.task.id));
        timeLogBloc.add(AddTimeLoggingObjectEvent(
            topLevelTaskWithQueueStatus.task.id,
            topLevelTaskWithQueueStatus.task.id));
      },
    );
  }
}

class AllSubtasksListTile extends StatelessWidget {
  final TaskWithQueueStatus topLevelTaskWithQueueStatus;

  const AllSubtasksListTile(
      {required this.topLevelTaskWithQueueStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (Task child in topLevelTaskWithQueueStatus.task.children)
          SingleSubtask(child, topLevelTaskWithQueueStatus.task, 1),
      ],
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
    final TimeLoggingBloc timeLogBloc = context.read<TimeLoggingBloc>();
    final TaskQueueBloc taskQueueBloc = context.read<TaskQueueBloc>();
    int? selectedTaskId;
    if (taskQueueBloc.state is TaskQueueReady) {
      final state = taskQueueBloc.state as TaskQueueReady;
      selectedTaskId = state.selectedTask;
    } else {
      logger.d("This state should not be accessible: queue not initialized");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          textColor: const Color(0xFF636573),
          selected: task.id == selectedTaskId,
          selectedColor: Theme.of(context).colorScheme.primary,
          onTap: () {
            taskQueueBloc.add(SelectQueuedTaskEvent(task.id));
            timeLogBloc
                .add(AddTimeLoggingObjectEvent(task.id, topLevelTask.id));
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 24.0 * level),
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
