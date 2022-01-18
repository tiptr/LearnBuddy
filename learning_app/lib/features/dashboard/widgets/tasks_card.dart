import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/dashboard/util/calculate_progress_data.dart';
import 'package:learning_app/constants/page_ids.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_item.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_progress.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/util/nav_cubit.dart';

class TasksCard extends StatelessWidget {
  const TasksCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TaskState>(
      builder: (context, state) {
        // This only checks for the success state, we might want to check for
        // errors in the future here.
        if (state is! TasksLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<List<ListReadTaskDto>>(
          stream: state.selectedListViewTasksStream,
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

            // Todo: use a setting for 2 here
            var tasksProgressData = calculateProgressData(snapshot.data!, 2);

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
                  physics: const AlwaysScrollableScrollPhysics(),
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
                      // TODO: not only navigate to the task page, but automatically activate a filter that only shows the tasks of the current day (and overdue)
                      BlocProvider.of<NavCubit>(context)
                          .navigateTo(PageId.tasks);
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackgroundSoft,
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
      },
    );
  }
}
