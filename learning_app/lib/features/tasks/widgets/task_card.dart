import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';

const double iconSize = 18.0;

class TaskCard extends StatelessWidget {
  final Task _task;

  const TaskCard({Key? key, required Task task})
      : _task = task,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    const borderRadius = 15.0;
    return Dismissible(
        key: Key(_task.id.toString()),
        onDismissed: (_) =>
            BlocProvider.of<TaskCubit>(context).deleteTaskById(_task.id),
        child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: Colors.white,
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Row(children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(Colors.grey),
                value: _task.done,
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  BlocProvider.of<TaskCubit>(context).toggleDone(_task);
                },
              )
            ]),
          ),
        ));
  }
}
