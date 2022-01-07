import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_item.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_card_progress.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';

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

            // Only consider tasks with a due date
            final tasks =
                snapshot.data!.where((task) => task.dueDate != null).toList();

            // Sort the task so the next due dates come first
            tasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

            const taskAmount = 2;

            final hasMore = tasks.length > taskAmount;
            final upcomingTasks = tasks.take(taskAmount).toList();

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
                const TasksCardProgress(
                  progress: 4 / 7,
                ),
                const SizedBox(height: 15.0),
                ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: upcomingTasks.length,
                  itemBuilder: (BuildContext ctx, int idx) => TasksCardItem(
                    task: upcomingTasks[idx],
                  ),
                ),
                // Only display "Weitere anzeigen ->" when there are more to display
                if (hasMore)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Weitere anzeigen",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.grey)
                    ],
                  )
              ],
            );
          },
        );
      },
    );
  }
}
