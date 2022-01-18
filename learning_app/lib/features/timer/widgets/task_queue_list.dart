import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/util/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class TaskQueueList extends StatefulWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  final Stream<bool> panelOpenedInformer;

  //final List<TaskWithQueueStatus>? taskList;

  const TaskQueueList({
    required this.scrollController,
    required this.panelController,
    required this.panelOpenedInformer,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskQueueList> createState() => _TaskQueueListState();
}

class _TaskQueueListState extends State<TaskQueueList> {
  _TaskQueueListState();

  @override
  void initState() {
    super.initState();

    widget.panelOpenedInformer.listen((event) async {
      // This is used to fix the drag-and-drop reordering of
      // the tasks, in the case that the list is scrolled up
      // completely
      // Please do not modify without discussing it first
      if (widget.scrollController.offset < 10) {
        final position = widget.scrollController.position;

        position.applyContentDimensions(
            double.negativeInfinity, double.infinity);
        position.jumpTo(10.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskQueueBloc, TaskQueueState>(
        // buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
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
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackgroundSoft
                        .withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                  // Please do not modify without discussing it first
                  if (widget.scrollController.offset < 10) {
                    widget.scrollController.jumpTo(10.0);
                  }
                },
                child: ReorderableListView(
                  anchor: 0.05, // This is important for making drag and drop
                  // work. Please leave this anchor as it is.
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
      for (int i = 0; i < list.length; i++)
        Dismissible(
          key: Key(list[i].task.id.toString()),
          child: customExpansionTile(list[i], i),
          onDismissed: (direction) {
            context
                .read<TaskQueueBloc>()
                .add(RemoveFromQueueEvent(list[i].task.id));
          },
        )
    ];
  }

  Widget customExpansionTile(TaskWithQueueStatus task, int index) {
    final TaskQueueBloc taskQueueBloc = context.read<TaskQueueBloc>();
    int? selectedTaskId;
    if (taskQueueBloc.state is TaskQueueReady) {
      final state = taskQueueBloc.state as TaskQueueReady;
      selectedTaskId = state.selectedTask;
    } else {
      logger.d("This state should not be accessible: queue not initialized");
    }

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
                color: task.task.category?.color ??
                    Theme.of(context).colorScheme.noCategoryDefaultColor,
                height: 50.0,
                width: 10.0,
              ),
            ),
            iconColor: Theme.of(context).colorScheme.onBackground,
            collapsedIconColor: Theme.of(context).colorScheme.onBackground,
            initiallyExpanded: false,
            childrenPadding: const EdgeInsets.only(left: 0.0, right: 10.0),
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
                color: task.task.category?.color ??
                    Theme.of(context).colorScheme.noCategoryDefaultColor,
                height: 50.0,
                width: 10.0,
              ),
            ),
            iconColor: Theme.of(context).colorScheme.onBackground,
            textColor: Theme.of(context).colorScheme.onBackground,
            selected: task.task.id == selectedTaskId,
            selectedColor: Theme.of(context).colorScheme.primary,
          );
  }
}
