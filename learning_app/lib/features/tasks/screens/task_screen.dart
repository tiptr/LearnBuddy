import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TasksCubit, TaskState>(
        builder: (context, state) {
          // This only checks for the success state, we might want to check for
          // errors in the future here.
          if (state is! TasksLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.tasks.length,
            itemBuilder: (BuildContext ctx, int idx) =>
                TaskCard(task: state.tasks[idx]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToTaskAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
