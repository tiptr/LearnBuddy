import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/categories/constants/selection_colors.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

const double iconSize = 14.0;

/// The card used inside the the main tasks list as well as for the subtasks (!)
class TaskCard extends StatelessWidget {
  final ListReadTaskDto _task;
  final bool _isSubTaskCard;

  // calculated:
  final String _formattedDueDate;
  final bool _isOverDue;
  final String _formattedTimeEstimation;
  final bool _isEstimated;
  final Color _categoryColor;

  TaskCard(
      {Key? key, required ListReadTaskDto task, bool isSubTaskCard = false})
      : _task = task,
        _isSubTaskCard = isSubTaskCard,
        // calculated:
        _formattedDueDate =
            task.dueDate.toListViewFormat(ifNull: 'Ohne Fälligkeit'),
        _isOverDue = task.dueDate.isInPast(),
        _formattedTimeEstimation = task.remainingTimeEstimation
            .toListViewFormat(ifNull: 'Keine Zeitschätzung'),
        _isEstimated = task.remainingTimeEstimation == null ? false : true,
        _categoryColor = isSubTaskCard
            ? const Color(0xFF949597)
            : (task.categoryColor ?? noCategoryDefaultColor),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
              _task.done ? const Color(0xB8FFFFFF) : const Color(0x00000000),
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
                      // TODO: Use color of category once added
                      left: BorderSide(width: 12.5, color: _categoryColor),
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

                  // This column holds the title + datechip
                  // and the description + further info row
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // Upper Row
                  //     _buildUpperRow(context),
                  //     // Lower Row
                  //     _buildLowerRow()
                  //   ],
                  // ),
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
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          mainAxisAlignment: _task.keywords.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                color: const Color(0xFF40424A),
              ),
            ),

            // Keywords
            if (_task.keywords.isNotEmpty)
              Text(
                _task.keywords.join(', '),
                maxLines: 2,
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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
          ),

          // stats
          Padding(
            padding: const EdgeInsets.only(
              top: 0.0,
              bottom: 0.0,
              right: 4.0, // match the margin of the date chip
              left: 0.0
            ),
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

  Widget _buildUpperRow(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Expanded(
            flex: 70,
            child: Text(
              _task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: _task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 2.0,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Date Chip
          Expanded(
            flex: 30,
            child: Chip(
              label: Text(
                _formattedDueDate,
                style: TextStyle(
                  color: _isOverDue ? Colors.white : Colors.black,
                ),
              ),
              avatar: Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: _isOverDue ? Colors.white : Colors.black,
              ),
              backgroundColor: _isOverDue
                  ? Colors.purpleAccent
                  : Theme.of(context).cardColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLowerRow() {
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _task.keywords.join(', '),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (!_task.done && _isEstimated)
                  ? Row(
                      children: [
                        const Icon(Icons.hourglass_top, size: iconSize),
                        Text(_formattedTimeEstimation),
                      ],
                    )
                  : Row(),
              Container(
                margin: const EdgeInsets.only(left: 7.5),
                child: (_task.subTaskCount > 0)
                    ? Row(
                        children: [
                          const Icon(Icons.dynamic_feed_outlined,
                              size: iconSize),
                          const SizedBox(width: 5.0),
                          Text(
                              '${_task.finishedSubTaskCount} / ${_task.subTaskCount}'),
                        ],
                      )
                    : Row(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
