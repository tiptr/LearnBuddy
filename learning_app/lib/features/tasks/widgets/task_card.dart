import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_delete_dialog.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const double iconSize = 14.0;

final double verticalPaddingCardContentTopLevel =
    BasicCard.padding.innerVertical;
const double verticalPaddingCardContentSubTasks = 2;

final double distanceBetweenCardsTopLevel = BasicCard.padding.outerVertical;
const double distanceBetweenCardsSubTasks = 7.0;

/// The card used inside the the main tasks list as well as for the subtasks (!)
class TaskCard extends StatefulWidget {
  final ListReadTaskDto _task;
  final bool _isSubTaskCard;

  // calculated:
  final String _formattedDueDate;
  final bool _isOverDue;
  final String _formattedTimeEstimation;
  final bool _isEstimated;
  final Color _categoryColor;

  TaskCard(
      {Key? key,
      required ListReadTaskDto task,
      required BuildContext context,
      bool isSubTaskCard = false})
      : _task = task,
        _isSubTaskCard = isSubTaskCard,
        // calculated:
        _formattedDueDate = task.dueDate
            .formatDependingOnCurrentDate(ifNull: 'Ohne Fälligkeit'),
        _isOverDue = task.dueDate.isInPast(),
        _formattedTimeEstimation = task.remainingTimeEstimation
            .toListViewFormat(ifNull: 'Keine Zeitschätzung'),
        _isEstimated = task.remainingTimeEstimation == null ? false : true,
        _categoryColor = task.categoryColor ??
            Theme.of(context).colorScheme.noCategoryDefaultColor,
        super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = widget._task.done;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(widget._task.id.toString()),

      // The start action pane is the one at the left or the top side.
      startActionPane: widget._isSubTaskCard
          ? null
          : ActionPane(
              extentRatio: 0.4,
              dragDismissible: true,
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // We will abuse the dismissing functionality here for the ability
              // to quickly select / disselect the task with one swipe only
              dismissible: DismissiblePane(
                onDismissed: () {
                  // Empty, because we do not actually dismiss the card
                },
                confirmDismiss: () async {
                  // This is called before onDismissed and before the card is
                  // dismissed

                  // Toggle queue status
                  BlocProvider.of<TasksCubit>(context).toggleQueued(
                      taskId: widget._task.id, queued: !widget._task.isQueued);

                  // Always return false, so the card will not be dismissed
                  return false;
                },
                closeOnCancel: true,
              ),

              // All actions are defined in the children parameter.
              children: [
                // Slide to the right to select / deselect a task for the queue
                SlidableAction(
                  // For further styling, also a CustomSlidableAction exists, with
                  // which a custom widget can be designed for this
                  onPressed: (context) {
                    // Toggle queue status
                    BlocProvider.of<TasksCubit>(context).toggleQueued(
                        taskId: widget._task.id,
                        queued: !widget._task.isQueued);
                  },
                  autoClose: false,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  icon: widget._task.isQueued
                      ? Icons.remove_from_queue_outlined
                      : Icons.add_to_queue_outlined,
                  label: widget._task.isQueued
                      ? 'Später bearbeiten'
                      : 'Heute bearbeiten',
                ),
              ],
            ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onDeleteTask(widget._task);
            },
            autoClose: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete_outline_outlined,
            label: 'Endgültig löschen',
          ),
          // More actions could be defined here, later
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    double borderRadius = BasicCard.borderRadius;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal:
              widget._isSubTaskCard ? 20.0 : BasicCard.padding.outerHorizontal,
          vertical: widget._isSubTaskCard
              ? distanceBetweenCardsSubTasks
              : distanceBetweenCardsTopLevel),
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                existingTaskId: widget._task.id,
                topLevelParentId: widget._task.topLevelParentId,
              ),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            // Marking tasks in the playlist
            side: widget._task.isQueued
                ? BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 1.5,
                  )
                : BorderSide.none,
          ),
          color: Theme.of(context).colorScheme.cardColor,
          shadowColor: Theme.of(context).colorScheme.shadowColor,
          elevation: _checked
              ? BasicCard.elevation.low
              : (widget._isSubTaskCard ? 3.0 : BasicCard.elevation.high),
          child: Stack(
            children: <Widget>[
              Align(
                child: ColorFiltered(
                  // Grey out when done -> Overlay with semitransparent white; Else
                  // overlay with fulltransparent "black" (no effect)
                  colorFilter: ColorFilter.mode(
                    _checked
                        ? Theme.of(context).colorScheme.greyOutOverlayColor
                        : Colors.transparent,
                    Theme.of(context).colorScheme.isDark
                        ? BlendMode.darken
                        : BlendMode.lighten,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                      left: widget._isSubTaskCard ? 10.0 : 3.0,
                    ),
                    // category:
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: BasicCard.borderRadius,
                          color: widget._isSubTaskCard
                              ? Colors.transparent
                              : widget._categoryColor,
                        ),
                      ),
                    ),

                    height: widget._isSubTaskCard ? 75.0 : BasicCard.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Checkbox
                        Expanded(
                          flex: 10,
                          child: Transform.scale(
                            scale: widget._isSubTaskCard ? 1.3 : 1.5,
                            child: Checkbox(
                              checkColor:
                                  Theme.of(context).colorScheme.checkColor,
                              fillColor: MaterialStateProperty.all(
                                widget._categoryColor,
                              ),
                              value: _checked,
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                // Directly change the card status, so the user has
                                // a responsive feedback
                                setState(() {
                                  _checked = !_checked;
                                });
                                // Actually change the attribute
                                BlocProvider.of<TasksCubit>(context).toggleDone(
                                    widget._task.id, !widget._task.done);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        // Content
                        Expanded(
                          flex: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Left Row: title + keywords
                              _TitleKeyWordsColumn(
                                checked: _checked,
                                isSubTaskCard: widget._isSubTaskCard,
                                keywords: widget._task.keywords,
                                taskTitle: widget._task.title,
                              ),
                              const SizedBox(width: 10.0), // min distance
                              // Right Row: due date + stats
                              _DueDateStatsColumn(
                                checked: _checked,
                                dueDate: widget._task.dueDate,
                                formattedDueDate: widget._formattedDueDate,
                                isEstimated: widget._isEstimated,
                                formattedTimeEstimation:
                                    widget._formattedTimeEstimation,
                                isSubTaskCard: widget._isSubTaskCard,
                                isOverDue: widget._isOverDue,
                                finishedSubTaskCount:
                                    widget._task.finishedSubTaskCount,
                                subTaskCount: widget._task.subTaskCount,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // The label marking tasks in the playlist
              if (widget._task.isQueued)
                Positioned(
                  top: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Heute bearbeiten",
                      style:
                          Theme.of(context).textTheme.textStyle4.withBackground,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  /// Handles the 'save task' functionality
  Future<bool> onDeleteTask(ListReadTaskDto taskDto) async {
    var confirmed =
        await taskDeleteConfirmDialog(context: context, title: taskDto.title);

    if (confirmed) {
      BlocProvider.of<TasksCubit>(context).deleteTaskById(taskDto.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Aufgabe erfolgreich gelöscht!',
            style: Theme.of(context).textTheme.textStyle2.withSucess,
          ),
          backgroundColor: Theme.of(context).colorScheme.subtleBackgroundGrey,
        ),
      );

      return true;
    }

    return false;
  }
}

class _TitleKeyWordsColumn extends StatelessWidget {
  final bool isSubTaskCard;
  final List<String> keywords;
  final String taskTitle;
  final bool checked;

  const _TitleKeyWordsColumn({
    Key? key,
    required this.isSubTaskCard,
    required this.keywords,
    required this.taskTitle,
    required this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = isSubTaskCard
        ? Theme.of(context).textTheme.textStyle3.withOnBackgroundHard.withBold
        : Theme.of(context).textTheme.textStyle2.withOnBackgroundHard.withBold;
    return Expanded(
      flex: 70,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: isSubTaskCard
                ? verticalPaddingCardContentSubTasks
                : verticalPaddingCardContentTopLevel),
        child: Column(
          mainAxisAlignment: keywords.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              taskTitle,
              maxLines: 2,
              style: checked
                  ? titleStyle.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2.0,
                    )
                  : titleStyle,
            ),

            // Keywords
            if (keywords.isNotEmpty)
              Text(
                keywords.join(', '),
                maxLines: isSubTaskCard ? 1 : 2,
                style:
                    Theme.of(context).textTheme.textStyle4.withOnBackgroundSoft,
              ),
          ],
        ),
      ),
    );
  }
}

class _DueDateStatsColumn extends StatelessWidget {
  final bool isSubTaskCard;
  final DateTime? dueDate;
  final String formattedDueDate;
  final bool isOverDue;
  final bool isEstimated;
  final String formattedTimeEstimation;
  final bool checked;
  final int subTaskCount;
  final int finishedSubTaskCount;

  const _DueDateStatsColumn({
    Key? key,
    required this.isSubTaskCard,
    required this.dueDate,
    required this.formattedDueDate,
    required this.isOverDue,
    required this.isEstimated,
    required this.formattedTimeEstimation,
    required this.checked,
    required this.subTaskCount,
    required this.finishedSubTaskCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle dueDateStyle = Theme.of(context).textTheme.textStyle4;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: isSubTaskCard
              ? verticalPaddingCardContentSubTasks
              : verticalPaddingCardContentTopLevel),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Date Chip
          Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4.0),
            label: Text(
              (dueDate != null) ? formattedDueDate : '',
              textAlign: TextAlign.end,
              style: isOverDue
                  ? dueDateStyle.withOnSecondary
                  : dueDateStyle.withOnBackgroundHard,
            ),
            labelPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: isOverDue ? 4 : 0,
            ),
            avatar: (dueDate != null)
                ? Icon(
                    Icons.today_outlined,
                    size: 16,
                    color: isOverDue
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.onBackgroundHard,
                  )
                : null,
            backgroundColor: isOverDue
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.cardColor,
            // Required, because Colors.transparent does not work.
            // The background is transparent through the card all
            // the way to the screen background, then.
          ),

          // stats
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                right: 4.0, // match the margin of the date chip
                left: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Remaining time estimation, only if provided
                if (!checked && isEstimated)
                  Row(
                    children: [
                      Icon(
                        Icons.hourglass_top,
                        size: iconSize,
                        color: Theme.of(context).colorScheme.onBackgroundSoft,
                      ),
                      Text(formattedTimeEstimation,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .textStyle4
                              .withOnBackgroundSoft),
                    ],
                  ),
                if (subTaskCount > 0)
                  Container(
                    margin: const EdgeInsets.only(left: 7.5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.dynamic_feed_outlined,
                          size: iconSize,
                          color: Theme.of(context).colorScheme.onBackgroundSoft,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '$finishedSubTaskCount / $subTaskCount',
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .textStyle4
                              .withOnBackgroundSoft,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
