import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TaskQueueList extends StatefulWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  //final List<TaskWithQueueStatus>? taskList;

  const TaskQueueList(
      {required this.scrollController, required this.panelController, Key? key})
      : super(key: key);

  @override
  State<TaskQueueList> createState() => _TaskQueueListState();
}

class _TaskQueueListState extends State<TaskQueueList> {
  _TaskQueueListState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget._controller.jumpTo(20.0);
    return BlocBuilder<TaskQueueBloc, TaskQueueState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          if (state is TaskQueueReady) {
            return Column(
              children: <Widget>[
                // The indicator on top showing the draggability of the panel
                InkWell(
                  onTap: () {
                    // Toggle the panel
                    widget.panelController.isPanelOpen
                        ? widget.panelController.close()
                        : widget.panelController.open();
                  },
                  child: Center(
                    heightFactor: 5,
                    child: Container(
                      height: 5,
                      width: 80,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCBCCCD),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),

                // The list of tasks:
                Flexible(
                  child: GestureDetector(
                    onTapDown: (details) {
                      // This is used to fix the drag-and-drop reordering of
                      // the tasks, in the case that the list is scrolled up
                      // completely
                      if (widget.scrollController.offset < 10) {
                        widget.scrollController.animateTo(10,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease);
                      }
                    },
                    onLongPressDown: (details) {
                      // This is used to fix the drag-and-drop reordering of
                      // the tasks, in the case that the list is scrolled up
                      // completely
                      if (widget.scrollController.offset < 10) {
                        widget.scrollController.animateTo(10,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease);
                      }
                    },
                    child: ReorderableListView(
                      scrollController: widget.scrollController,
                      children: generateExpansionTiles(state.tasks),
                      onReorder: (oldIndex, newIndex) {
                        setState(
                          () {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final TaskWithQueueStatus item =
                                state.tasks.removeAt(oldIndex);
                            state.tasks.insert(newIndex, item);
                            context
                                .read<TaskQueueBloc>()
                                .add(UpdateQueueOrderEvent(state.tasks));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  List<Widget> generateExpansionTiles(List<TaskWithQueueStatus> list) {
    return [
      for (int i = 0; i < list.length; i++) customExpansionTile(list[i], i)
    ];
  }

  Widget customExpansionTile(TaskWithQueueStatus task, int index) {
    return task.task.children.isNotEmpty
        // Tasks with subtasks are expandable:
        ? ExpansionTile(
            key: Key(task.task.title),
            title: TopLevelListTile(
              topLevelTaskWithQueueStatus: task,
            ),
            children: <Widget>[
              AllSubtasksListTile(topLevelTaskWithQueueStatus: task)
            ],
            leading: Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: ColorIndicator(
                color: task.task.category?.color ?? Colors.grey,
                height: 50.0,
                width: 10.0,
              ),
            ),
            iconColor: const Color(0xFF636573),
            collapsedTextColor: const Color(0xFF636573),
            // textColor: const Color(0xFF40424A),
            textColor: const Color(0xFF636573),

            childrenPadding: const EdgeInsets.only(left: 20.0, right: 10.0),
          )
        // Tasks without subtasks are not expandable:
        : ListTile(
            key: Key(task.task.title),
            title: TopLevelListTile(
              topLevelTaskWithQueueStatus: task,
            ),
            leading: Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: ColorIndicator(
                color: task.task.category?.color ?? Colors.grey,
                height: 50.0,
                width: 10.0,
              ),
            ),
            iconColor: const Color(0xFF636573),
            textColor: const Color(0xFF636573),
            // visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
          );
  }
}
