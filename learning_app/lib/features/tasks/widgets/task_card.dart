import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';

const double iconSize = 18.0;

class TaskCard extends StatelessWidget {
  final Task _task;

  const TaskCard({Key? key, required Task task})
      : _task = task,
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
    // TODO use real values from Task
    var categoryColor =
        _task.id % 2 == 1 ? Colors.red : Colors.lightBlue.shade600;
    var checkboxColor =
        categoryColor; // Colors.green.shade400; // Colors.black54; //categoryColor;
    // const categoryColor = Colors.lightBlue.shade600;
    //////////////////////////////////////////////////

    return Dismissible(
      key: Key(_task.id.toString()),
      onDismissed: (_) =>
          BlocProvider.of<TaskCubit>(context).deleteTaskById(_task.id),
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
                left: BorderSide(width: 12.5, color: categoryColor),
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
                        _task.done ? checkboxColor : categoryColor,
                      ),
                      value: _task.done,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        BlocProvider.of<TaskCubit>(context).toggleDone(_task);
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
                // TODO: Use real date here
                _task.id % 2 == 1 ? "Heute" : "1. Dez",
                style: TextStyle(
                  color: _task.id % 2 == 1 ? Colors.black : Colors.white,
                ),
              ),
              avatar: Icon(
                // TODO check if task is overdue for color selection
                Icons.calendar_today_outlined,
                size: 16,
                color: _task.id % 2 == 1 ? Colors.black : Colors.white,
              ),
              backgroundColor: _task.id % 2 == 1
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.purpleAccent,
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
            _task.id % 3 == 1 ? "Lernen, Nachhilfe" : "Hausaufgabe",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: const [
                  Icon(Icons.hourglass_top, size: iconSize),
                  // TODO use real time of Task
                  Text("~ 1 h"),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 7.5),
                child: Row(
                  children: const [
                    Icon(Icons.dynamic_feed_outlined, size: iconSize),
                    SizedBox(width: 5.0),
                    // TODO use real completion of Task
                    Text("5 / 8")
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
