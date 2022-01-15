import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_item.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_progress.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/util/logger.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

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
                  'Keine anstehenden Aufgaben.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.textStyle3,
                ),
              );
            }

            final dueTasks = snapshot.data!.where((task) {
              // Only consider tasks with a due date
              return task.dueDate != null &&
                  // And only those that have a due date today or earlier
                  task.dueDate.compareDayOnly(DateTime.now()) <= 0;
            }).toList();

            // Sort the task so the next due dates come first
            dueTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

            const taskAmount = 2;

            final hasMore = dueTasks.length > taskAmount;
            final amountOfFurtherDueTasks = dueTasks.length - taskAmount;
            final upcomingTasks = dueTasks.take(taskAmount).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TasksCardProgress(
                  progress: 4 / 7,
                ),
                const SizedBox(height: 25.0),
                ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: upcomingTasks.length,
                  itemBuilder: (BuildContext ctx, int idx) => TasksCardItem(
                    task: upcomingTasks[idx],
                  ),
                ),
                // Only display further due tasks, if there are more to display
                if (hasMore)
                  InkWell(
                    onTap: () {
                      // TODO: Will be done in #57
                      logger.d("Navigate to Task Page");
                      // TODO: not only navigate to the task page, but automatically activate a filter that only shows the tasks of the current day (and overdue)
                    },
                    child: Ink(
                      child: Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$amountOfFurtherDueTasks weitere bis heute fällig",
                              style: Theme.of(context)
                                  .textTheme
                                  .textStyle2
                                  .withBold
                                  .withOnBackgroundSoft,
                            ),
                            Icon(Icons.arrow_forward,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackgroundSoft)
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
