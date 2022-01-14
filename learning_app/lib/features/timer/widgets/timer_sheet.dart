import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';



class TaskQueueList extends StatefulWidget {
  final ScrollController _controller;

  const TaskQueueList(this._controller, {Key? key})
      : super(key: key);

  @override
  State<TaskQueueList> createState() => _TaskQueueListState();
}

class _TaskQueueListState extends State<TaskQueueList> {

   late final List<TaskWithQueueStatus>? taskList;

  _TaskQueueListState(){
    taskList = context.select((TaskQueueBloc bloc) => bloc.state.getTasks);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(taskList == null) {
      return const CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ReorderableListView(
        scrollController: widget._controller,
        children: generateExpansionTiles(taskList!),
        onReorder: (oldIndex, newIndex) {
          print('now');
          setState(
                () {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final TaskWithQueueStatus item = taskList!.removeAt(oldIndex);
              taskList!.insert(newIndex, item);
            },
          );
        },


      ),
    );
  }

  List<ExpansionTile> generateExpansionTiles(List<TaskWithQueueStatus> list) {
    return [
      for (int i = 0; i < list.length; i++) customExpansionPanel(list[i], i)
    ];
  }

  ExpansionTile customExpansionPanel(TaskWithQueueStatus task, int index) {
    return ExpansionTile(
      key: Key(task.task.title),
      title: TopLevelListTile(topLevelTaskWithQueueStatus: task,),
      children: <Widget> [SubtaskFullTile(topLevelTaskWithQueueStatus: task)],
    );

  }
}
