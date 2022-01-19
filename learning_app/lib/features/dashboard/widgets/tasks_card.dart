import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/features/dashboard/util/calculate_progress_data.dart';
import 'package:learning_app/constants/page_ids.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_item.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_progress.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/util/nav_cubit.dart';
import 'package:drift/drift.dart' as drift;

class TasksCard extends StatelessWidget {
  const TasksCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream =
        BlocProvider.of<TasksCubit>(context).getDetailsDtoStreamForDashboard();

    return StreamBuilder<List<ListReadTaskDto>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Du hast aktuell keine anstehenden Aufgaben.\nGehe in den Aufgabenbereich, um eine Aufgabe anzulegen',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.textStyle4,
            ),
          );
        }

        var tasksProgressData = calculateProgressData(
            snapshot.data!,
            SharedPreferencesData.taskCountOnDashboard ??
                defaultTaskCountOnDashboard);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            TasksCardProgress(
              amountDone: tasksProgressData.doneTaskCount,
              amountTotal: tasksProgressData.totalTaskCount,
              remainingDuration: tasksProgressData.remainingDuration,
            ),
            const SizedBox(height: 25.0),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: tasksProgressData.upcomingTasks.length,
              itemBuilder: (BuildContext ctx, int idx) => TasksCardItem(
                task: tasksProgressData.upcomingTasks[idx],
              ),
            ),
            // Only display further due tasks, if there are more to display
            if (tasksProgressData.hasMore)
              InkWell(
                onTap: () {
                  BlocProvider.of<TasksCubit>(context).loadFilteredTasks(
                      const TaskFilter(dueToday: drift.Value(true)));
                  BlocProvider.of<NavCubit>(context).navigateTo(PageId.tasks);
                },
                child: Ink(
                  child: Container(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${tasksProgressData.moreCount} weitere bis heute fällig",
                          style: Theme.of(context)
                              .textTheme
                              .textStyle2
                              .withBold
                              .withOnBackgroundSoft,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.onBackgroundSoft,
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
