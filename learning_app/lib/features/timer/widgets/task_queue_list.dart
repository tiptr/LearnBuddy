import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';



class TaskQueueList extends StatefulWidget {
  final ScrollController _controller;

  //final List<TaskWithQueueStatus>? taskList;

  const TaskQueueList(this._controller, {Key? key})
      : super(key: key);

  @override
  State<TaskQueueList> createState() => _TaskQueueListState();
}

class _TaskQueueListState extends State<TaskQueueList> {


  _TaskQueueListState();



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskQueueBloc, TaskQueueState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          if(state is TaskQueueReady) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ReorderableListView(
                scrollController: widget._controller,
                children: generateExpansionTiles(state.tasks),
                onReorder: (oldIndex, newIndex) {
                  setState(
                        () {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final TaskWithQueueStatus item = state.tasks
                          .removeAt(
                          oldIndex);
                      state.tasks.insert(newIndex, item);
                      context.read<TaskQueueBloc>().add(
                          UpdateQueueOrderEvent(state.tasks));
                    },
                  );
                },


              ),
            );
          }
          else {
              return const CircularProgressIndicator();
          }
        }
      );
  }

  List<ExpansionTile> generateExpansionTiles(List<TaskWithQueueStatus> list) {
    return [
      for (int i = 0; i < list.length; i++) customExpansionTile(list[i], i)
    ];
  }

  ExpansionTile customExpansionTile(TaskWithQueueStatus task, int index) {
    return ExpansionTile(
      key: Key(task.task.title),
      title: TopLevelListTile(topLevelTaskWithQueueStatus: task,),
      children: <Widget> [SubtaskFullTile(topLevelTaskWithQueueStatus: task)],
    );

  }
}
