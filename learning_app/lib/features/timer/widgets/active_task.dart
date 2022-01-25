import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';
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
    final String estimatedTime = task.fullTimeEstimation.toListViewFormat();
    final Duration sumDuration = task.sumAllTimeLogs;
    final String timeSpent =
        (activeDuration == null ? sumDuration : sumDuration + activeDuration)
            .toListViewFormat();
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
              mainAxisAlignment: task.description != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.spaceAround,
              children: [
                if (parentTask.task.id != task.id) topLevelTaskWidget,
                Text(
                  task.title,
                  style: Theme.of(context)
                      .textTheme
                      .textStyle1
                      .withBold
                      .withOnBackgroundHard,
                ),
                if (task.description != null)
                  Text(task.description.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.textStyle2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.hourglass_top,
                      size: 15,
                      color: Theme.of(context).colorScheme.onBackgroundHard,
                    ),
                    Text(
                      "Urspr.: " + estimatedTime,
                      style: Theme.of(context)
                          .textTheme
                          .textStyle4
                          .withOnBackgroundHard,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.hourglass_bottom,
                      size: 15,
                      color: Theme.of(context).colorScheme.onBackgroundHard,
                    ),
                    Text(
                      "Aufgewendet: " + timeSpent,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .textStyle4
                          .withOnBackgroundHard,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: gradientIcon(
                  iconData: Icons.clear,
                  context: context,
                ),
                onPressed: () {
                  TimeLoggingBloc timeLoggingBloc =
                      context.read<TimeLoggingBloc>();
                  timeLoggingBloc.add(const RemoveTimeLoggingObjectEvent());
                  context.read<TaskQueueBloc>().add(RemoveSelectedTaskEvent());
                },
              ),
              Checkbox(
                checkColor: Theme.of(context).colorScheme.checkColor,
                fillColor: MaterialStateProperty.all(
                  task.category?.color,
                ),
                value: task.doneDateTime == null ? false : true,
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  BlocProvider.of<TasksCubit>(context).toggleDone(
                      task.id, task.doneDateTime == null ? true : false);
                },
              ),
              Flexible(
                child: IconButton(
                  icon: gradientIcon(iconData: Icons.launch, context: context),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(
                          existingTaskId: task.id,
                          topLevelParentId: parentTask.task.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
