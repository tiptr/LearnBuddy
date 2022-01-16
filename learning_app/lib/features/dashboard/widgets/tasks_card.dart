import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/dashboard/util/calculate_progress_data.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_item.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_progress.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/logger.dart';

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
              return const Center(
                child: Text(
                  'Keine anstehenden Aufgaben.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF636573),
                  ),
                ),
              );
            }

            // Todo: use a setting for 2 here
            var tasksProgressData = calculateProgressData(snapshot.data!, 2);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Heutige Aufgaben",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35.0),
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
                              "${tasksProgressData.moreCount} weitere bis heute fällig",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.arrow_forward, color: Colors.grey)
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
