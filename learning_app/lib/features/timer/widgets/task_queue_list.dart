import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/timer/bloc/timer_bloc.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/widgets/suggested_leisure_activity_card.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';
import 'package:learning_app/util/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

const listTileHeight = 50;

class DraggableSheetView extends StatefulWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  final Stream<bool> panelOpenedInformer;
  final double panelMaxHeight;

  //final List<TaskWithQueueStatus>? taskList;

  const DraggableSheetView({
    required this.scrollController,
    required this.panelController,
    required this.panelOpenedInformer,
    required this.panelMaxHeight,
    Key? key,
  }) : super(key: key);

  @override
  State<DraggableSheetView> createState() => _DraggableSheetViewState();
}

class _DraggableSheetViewState extends State<DraggableSheetView> {
  _DraggableSheetViewState();

  @override
  void initState() {
    super.initState();

    widget.panelOpenedInformer.listen((event) async {
      // This is used to fix the drag-and-drop reordering of
      // the tasks, in the case that the list is scrolled up
      // completely
      // This has the purpose of not having the list at a scroll-
      // offset of 0, when dragging items down via drag and drop.
      // If that is the case, the whole sliding up panel is being
      // moved instead.
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
    final currentPomoMode =
        context.select((TimerBloc bloc) => bloc.state.getPomodoroMode());
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
            Flexible(
              child: GestureDetector(
                  onTapDown: (details) {
                    // This is used to fix the drag-and-drop reordering of
                    // the tasks, in the case that the list is scrolled up
                    // completely
                    // This has the purpose of not having the list at a scroll-
                    // offset of 0, when dragging items down via drag and drop.
                    // If that is the case, the whole sliding up panel is being
                    // moved instead.
                    if (widget.scrollController.offset < 10) {
                      widget.scrollController.jumpTo(10.0);
                    }
                  },
                  child: queuedTaskList(state, currentPomoMode)),
            ),
          ],
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  Widget queuedTaskList(TaskQueueReady state, PomodoroMode currentPomoMode) {
    return ReorderableListView(
      anchor: 0.05, // This is important for making drag and drop work.
      scrollController: widget.scrollController,
      children: generateExpansionTiles(state.tasks, currentPomoMode),
      onReorder: (oldIndex, newIndex) {
        // Ignore the pseudo element at the end:
        if (newIndex <= state.tasks.length) {
          setState(
            () {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final TaskWithQueueStatus item = state.tasks.removeAt(oldIndex);
              state.tasks.insert(newIndex, item);
              BlocProvider.of<TaskQueueBloc>(context)
                  .add(UpdateQueueOrderEvent(state.tasks));
            },
          );
        }
      },
    );
  }

  List<Widget> generateExpansionTiles(
      List<TaskWithQueueStatus> list, PomodoroMode currentPomoMode) {
    // If in pause mode, show leisure activity:
    if (currentPomoMode != PomodoroMode.concentration) {
      final List<Widget> widgetList = [];
      widgetList.add(const SuggestedLeisureActivityCard(
        key: Key('Leisure suggestion element for a timer list'),
      ));
      return widgetList;
    }

    // Productive mode -> If list empty, show placeholder
    if (list.isEmpty) {
      // return information placeholder instead
      final List<Widget> widgetList = [];
      widgetList.add(Container(
          key: const Key('Placeholder element for a empty list'),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
          child: Text(
            'Keine Aufgaben für die heutige Bearbeitung ausgewählt.\n\n'
            'Streiche in der Aufgabenliste einzelne Todos nach rechts, '
            'um sie für die Bearbeitung auszuwählen.',
            style: Theme.of(context).textTheme.textStyle3,
            maxLines: 5,
            textAlign: TextAlign.center,
          )));
      return widgetList;
    }

    // Productive mode and elements exist -> return actual list
    List<Widget> widgetList = [
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

    // Generate a placeholder element, if the list does not span the whole
    // view area
    // Reason: The list should not be scrolled to the top when using drag and
    // drop (because otherwise the panel will be closed as well)
    final missingHeight = widget.panelMaxHeight -
        (list.length * listTileHeight) // current actual height of the elements
        -
        50; // constant part of the panel

    if (missingHeight > 0) {
      widgetList.add(SizedBox(
        key: const Key('Placeholder element at the end of the list'),
        height: missingHeight,
      ));
    }

    return widgetList;
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
