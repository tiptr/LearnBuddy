import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        color: Colors.white,
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              // TODO: Use color of category once added
              left: BorderSide(width: 12.5, color: Colors.lightBlue.shade600),
            ),
            color: Colors.white,
          ),
          height: 100.0,
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
                      _task.done ? Colors.grey : Colors.lightBlue.shade600,
                    ),
                    value: _task.done,
                    shape: const CircleBorder(),
                    onChanged: (bool? value) {
                      BlocProvider.of<TaskCubit>(context).toggleDone(_task);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              // Title and Description
              Expanded(
                flex: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      _task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.5,
                      ),
                    ),
                    const Text("Description of the task"),
                  ],
                ),
              ),
              // Date and further info
              Expanded(
                flex: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Chip(
                      label: Text(
                        // TODO: Use real date here
                        "1. Dez",
                        style: TextStyle(color: Colors.white),
                      ),
                      avatar: Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.purpleAccent,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.hourglass_top, size: iconSize),
                              Text("~ 1 h"),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 7.5),
                            child: Row(
                              children: const [
                                Icon(Icons.dynamic_feed_outlined,
                                    size: iconSize),
                                SizedBox(width: 5.0),
                                Text("5 / 8")
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
