import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';

class TaskQueueList extends StatelessWidget {
  final ScrollController _controller;

  const TaskQueueList(this._controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocBuilder<TaskQueueBloc, TaskQueueState>(
          builder: (context, state) {
            if (state is TaskQueueReady) {
              return ListView.builder(
                controller: _controller,
                itemCount: state.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskQueueListTile(
                      topLevelTaskWithQueueStatus: state.tasks[index]);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
