import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';

class ActiveTaskBar extends StatelessWidget {
  const ActiveTaskBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeLoggingBloc, TimeLoggingState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        if (state is InactiveState) {
          return const Text("Nothing active.");
        }
        return ActiveTaskCard(state);
      },
    );
  }
}

class ActiveTaskCard extends StatelessWidget {
  final TimeLoggingState state;

  const ActiveTaskCard(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Container(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 12.5,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            const ActiveTaskContent(),
          ],
        ),
      ),
    );
  }
}


class ActiveTaskContent extends StatelessWidget {
  const ActiveTaskContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final TimeLoggingState state =  context.select((TimeLoggingBloc bloc) => bloc.state);
  late final Task task;
  late final String timeSpent;
  if (state is ActiveState){
    task = state.task;
    timeSpent = state.timeLog.duration.inSeconds.toString();
  }
  else if (state is InitializedState){
    task = state.task;
    timeSpent = 0.toString();
  }
  else {
    throw Error();
  }

    return Column(
      children: [
        Expanded(
          flex: 70,
          child: Text(
            task.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decorationThickness: 2.0,
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.hourglass_bottom),
            Text("Bereits aufgewendete Zeit: " + timeSpent),

          ],
        )
      ],
    );
  }
}

