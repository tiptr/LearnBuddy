import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/categories/constants/colors.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

const double iconSize = 18.0;

class TaskCard extends StatelessWidget {
  final ListReadTaskDto _task;
  final String _formattedDueDate;
  final bool _isOverDue;
  final String _formattedTimeEstimation;
  final bool _isEstimated;

  TaskCard({Key? key, required ListReadTaskDto task})
      : _task = task,
        _formattedDueDate =
            task.dueDate.toListViewFormat(ifNull: 'Ohne Fälligkeit'),
        _isOverDue = task.dueDate.isInPast(),
        _formattedTimeEstimation = task.remainingTimeEstimation
            .toListViewFormat(ifNull: 'Keine Zeitschätzung'),
        _isEstimated = task.remainingTimeEstimation == null ? false : true,
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

    //////////////////////////////////////////////////
    //----------For Testing multiple options----------
    var checkboxColor =
        _task.categoryColor; // Colors.green.shade400; // Colors.black54;
    //////////////////////////////////////////////////

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
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: _task.done ? CardElevation.low : CardElevation.high,
        child: ColorFiltered(
          // Grey out when done -> Overlay with semitransparent white; Else
          // overlay with fulltransparent "black" (no effect)
          colorFilter: ColorFilter.mode(
              _task.done ? const Color(0xB8FFFFFF) : const Color(0x00000000),
              BlendMode.lighten),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                // TODO: Use color of category once added
                left: BorderSide(
                    width: 12.5,
                    color: _task.categoryColor ?? noCategoryDefaultColor),
              ),
              color: Colors.white,
            ),
            height: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Checkbox
                Expanded(
                  flex: 10,
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(
                        _task.done ? checkboxColor : _task.categoryColor,
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
                const Spacer(),
                // Content
                Expanded(
                  flex: 80,
                  // This column holds the title + datechip
                  // and the description + further info row
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Upper Row
                      _buildUpperRow(context),
                      // Lower Row
                      _buildLowerRow()
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
                  : Theme.of(context).scaffoldBackgroundColor,
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
