import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';

class TaskQueueListWrapper extends StatelessWidget {
  final ScrollController _controller;

  const TaskQueueListWrapper(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskQueueBloc, TaskQueueState>(
        builder: (context, state) {
      if (state is TaskQueueReady) {
        return TaskQueueList(_controller, state.tasks);
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}

class TaskQueueList extends StatefulWidget {
  final ScrollController _controller;
  final List<TaskWithQueueStatus> taskList;

  const TaskQueueList(this._controller, this.taskList, {Key? key})
      : super(key: key);

  @override
  State<TaskQueueList> createState() => _TaskQueueListState();
}

class _TaskQueueListState extends State<TaskQueueList> {
  late final List<bool> _isOpen = List.filled(widget.taskList.length, false);

  _TaskQueueListState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        controller: widget._controller,
        child: ExpansionPanelList(
          children: generateExpansionTiles(widget.taskList),
          expansionCallback: (i, isOpen) {
            setState(() => _isOpen[i] = !isOpen);
          },
        ),
      ),
    );
  }

  List<ExpansionPanel> generateExpansionTiles(List<TaskWithQueueStatus> list) {
    return [
      for (int i = 0; i < list.length; i++) customExpansionPanel(list[i], i)
    ];
  }

  ExpansionPanel customExpansionPanel(TaskWithQueueStatus task, int index) {
    return ExpansionPanel(
      headerBuilder: (context, isOpen) {
        return TopLevelListTile(topLevelTaskWithQueueStatus: task,);
      },
      body: SubtaskFullTile(topLevelTaskWithQueueStatus: task),
      isExpanded: _isOpen[index],
    );

  }
}
