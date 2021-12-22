import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/task_state.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<TimeLoggingBloc>(context);
     return FutureBuilder(
      future: bloc.init(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else {
            return const TaskScreenContent();
          }
        }
        return Text(snapshot.connectionState.toString()) ;
      },
    );
  }
}



class TaskScreenContent extends StatelessWidget {
  const TaskScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
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
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToTaskAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}