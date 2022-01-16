import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';
import 'package:learning_app/constants/theme_constants.dart';

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
            child: Text("Keine Aufgabe zur Bearbeitung ausgewählt."),
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
    Duration? activeDuration;
    if (state is ActiveState) {
      task = state.task;
      parentTask = state.parentTask;
      activeDuration = state.timeLog.duration;
    } else if (state is InitializedState) {
      task = state.task;
      parentTask = state.parentTask;
    } else {
      throw InvalidStateException();
    }
    final String estimatedTime = task.fullTimeEstimation.toExactSecondsFormat();
    final Duration sumDuration = task.sumAllTimeLogs;
    final String timeSpent =
        (activeDuration == null ? sumDuration : sumDuration + activeDuration)
            .toExactSecondsFormat();
    final Widget topLevelTaskWidget = Text(
      "Unteraufgabe von: " + parentTask.task.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 0),
      margin: const EdgeInsets.only(top: 5, left: 5, right: 0),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 8,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: task.category?.color ??
                  Theme.of(context).colorScheme.noCategoryDefaultColor,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (parentTask.task.id != task.id) topLevelTaskWidget,
                Text(
                  task.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationThickness: 2.0,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xFF40424A)),
                ),
                if (task.description != null)
                  Text(
                    task.description.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF40424A),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_top,
                          size: 15,
                          color: Color(0xFF40424A),
                        ),
                        Text(
                          "Urspr.: " + estimatedTime,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF40424A),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.hourglass_bottom,
                          size: 15,
                          color: Color(0xFF40424A),
                        ),
                        Text(
                          "Aufgewendet: " + timeSpent,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF40424A),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if(task.doneDateTime != null)
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      TimeLoggingBloc timeLoggingBloc = context.read<TimeLoggingBloc>();
                      timeLoggingBloc.add(const RemoveTimeLoggingObjectEvent());
                    },
                )
              else
                Spacer(),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(
                  task.category?.color,
                ),
                value: task.doneDateTime == null? false : true,
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  BlocProvider.of<TasksCubit>(context)
                      .toggleDone(task.id, task.doneDateTime == null? true : false);
                },
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
