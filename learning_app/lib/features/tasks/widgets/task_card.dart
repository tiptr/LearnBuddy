import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

const double iconSize = 14.0;

const double verticalPaddingCardContentTopLevel = 10;
const double verticalPaddingCardContentSubTasks = 2;

const double distanceBetweenCardsTopLevel = 10.0;
const double distanceBetweenCardsSubTasks = 7.0;

/// The card used inside the the main tasks list as well as for the subtasks (!)
class TaskCard extends StatelessWidget {
  final ListReadTaskDto _task;
  final bool _isSubTaskCard;

  // calculated:
  final String _formattedDueDate;
  final bool _isOverDue;
  final String _formattedTimeEstimation;
  final bool _isEstimated;
  final Color? _categoryColor;

  TaskCard(
      {Key? key, required ListReadTaskDto task, bool isSubTaskCard = false})
      : _task = task,
        _isSubTaskCard = isSubTaskCard,
        // calculated:
        _formattedDueDate = task.dueDate
            .formatDependingOnCurrentDate(ifNull: 'Ohne Fälligkeit'),
        _isOverDue = task.dueDate.isInPast(),
        _formattedTimeEstimation = task.remainingTimeEstimation
            .toListViewFormat(ifNull: 'Keine Zeitschätzung'),
        _isEstimated = task.remainingTimeEstimation == null ? false : true,
        _categoryColor = task.categoryColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: _isSubTaskCard
              ? distanceBetweenCardsSubTasks
              : distanceBetweenCardsTopLevel),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    const borderRadius = 12.5;

    return Dismissible(
      key: Key(_task.id.toString()),
      onDismissed: (_) =>
          BlocProvider.of<TasksCubit>(context).deleteTaskById(_task.id),
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: Theme.of(context).cardColor,
        elevation: _task.done ? CardElevation.low : CardElevation.high,
        child: ColorFiltered(
          // Grey out when done -> Overlay with semitransparent white; Else
          // overlay with fulltransparent "black" (no effect)
          colorFilter: ColorFilter.mode(
              _task.done
                  ? Theme.of(context).colorScheme.greyOutOverlayColor
                  : Colors.transparent,
              BlendMode.lighten),
          child: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 10.0,
              left: _isSubTaskCard ? 10.0 : 3.0,
            ),
            // category:
            decoration: _isSubTaskCard
                ? null
                : BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          width: 12.5,
                          color: _categoryColor ??
                              Theme.of(context)
                                  .colorScheme
                                  .noCategoryDefaultColor),
                    ),
                  ),
            height: _isSubTaskCard ? 75.0 : 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Checkbox
                Expanded(
                  flex: 10,
                  child: Transform.scale(
                    scale: _isSubTaskCard ? 1.3 : 1.5,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(
                        _categoryColor,
                      ),
                      value: _task.done,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        BlocProvider.of<TasksCubit>(context)
                            .toggleDone(_task.id, !_task.done);
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
                      _buildTitleKeyWordsColumn(context),
                      const SizedBox(width: 10.0), // min distance
                      // Right Row: due date + stats
                      _buildDueDateStatsColumn(context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleKeyWordsColumn(BuildContext context) {
    return Expanded(
      flex: 70,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: _isSubTaskCard
                ? verticalPaddingCardContentSubTasks
                : verticalPaddingCardContentTopLevel),
        child: Column(
          mainAxisAlignment: _task.keywords.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              _task.title,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: _task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 2.0,
                fontSize: _isSubTaskCard ? 14 : 16,
                overflow: TextOverflow.ellipsis,
                color: const Color(0xFF40424A),
              ),
            ),

            // Keywords
            if (_task.keywords.isNotEmpty)
              Text(
                _task.keywords.join(', '),
                maxLines: _isSubTaskCard ? 1 : 2,
                style: const TextStyle(
                  color: Color(0xFF949597),
                  fontWeight: FontWeight.normal,
                  decorationThickness: 2.0,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDateStatsColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: _isSubTaskCard
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
              (_task.dueDate != null) ? _formattedDueDate : '',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: _isOverDue ? Colors.white : const Color(0xFF949597),
                fontWeight: FontWeight.normal,
                decorationThickness: 2.0,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            labelPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: _isOverDue ? 4 : 0,
            ),
            avatar: (_task.dueDate != null)
                ? Icon(
                    Icons.today_outlined,
                    size: 16,
                    color: _isOverDue ? Colors.white : const Color(0xFF949597),
                  )
                : null,
            backgroundColor: _isOverDue
                ? const Color(0xFF9E5EE1)
                : Theme.of(context).cardColor,
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
                if (!_task.done && _isEstimated)
                  Row(
                    children: [
                      const Icon(
                        Icons.hourglass_top,
                        size: iconSize,
                        color: Color(0xFF949597),
                      ),
                      Text(
                        _formattedTimeEstimation,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Color(0xFF949597),
                          fontWeight: FontWeight.normal,
                          decorationThickness: 2.0,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                if (_task.subTaskCount > 0)
                  Container(
                    margin: const EdgeInsets.only(left: 7.5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.dynamic_feed_outlined,
                          size: iconSize,
                          color: Color(0xFF949597),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '${_task.finishedSubTaskCount} / ${_task.subTaskCount}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Color(0xFF949597),
                            fontWeight: FontWeight.normal,
                            decorationThickness: 2.0,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
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
