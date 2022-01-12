import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

class ActiveTaskBar extends StatelessWidget {
  const ActiveTaskBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeLoggingBloc, TimeLoggingState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        final Widget content;
        if (state is InactiveState) {
          content = const Center(
            child: Text("Keine Aufgabe ist aktiv."),
          );
        } else {
          content = const ActiveTaskCard();
        }
        return SizedBox(
          width: double.infinity,
          height: 150,
          child: content,
        );
      },
    );
  }
}

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeLoggingState state =
        context.select((TimeLoggingBloc bloc) => bloc.state);
    final Task task;
    final TaskWithQueueStatus parentTask;
    if (state is ActiveState) {
      task = state.task;
      parentTask = state.parentTask;
    } else if (state is InitializedState) {
      task = state.task;
      parentTask = state.parentTask;
    } else {
      throw InvalidStateException();
    }
    final String estimatedTime = task.fullTimeEstimation.formatVarLength();
    final Duration sumDuration = task.sumAllTimeLogs;
    final String timeSpent = sumDuration.formatVarLength();
    final Widget topLevelTaskWidget = Text(
      parentTask.task.id == task.id
          ? "Top Level Aufgabe"
          : "Unteraufgabe von: " + parentTask.task.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 8,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: task.category?.color ?? Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                topLevelTaskWidget,
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2.0,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  task.description.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_top,
                          size: 20,
                        ),
                        Text(
                          "Ursprünglich: " + estimatedTime,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.hourglass_bottom, size: 20),
                        Text(
                          "Aufgewendet: " + timeSpent,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
