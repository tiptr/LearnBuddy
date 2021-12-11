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
    return Dismissible(
        key: Key(_task.id.toString()),
        onDismissed: (_) =>
            BlocProvider.of<TaskCubit>(context).deleteTask(_task.id!),
        child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              children: [
                _titleRow(context),
                const SizedBox(height: 7.5),
                _subtitleRow(context),
                const SizedBox(height: 5.0),
                _tagRow()
              ],
            ),
          ),
        ));
  }

  Widget _titleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              child: SizedBox(
                height: 32.0,
                width: 32.0,
                child: Checkbox(
                  value: _task.done,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool? _) {
                    BlocProvider.of<TaskCubit>(context).toggleDone(_task);
                  },
                ),
              ),
            ),
            Text(
              _task.title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            )
          ],
        ),
        Row(
          children: const [
            Icon(Icons.calendar_today, size: iconSize, color: Colors.red),
            SizedBox(width: 5.0),
            Text("1. Dez"),
          ],
        )
      ],
    );
  }

  Widget _subtitleRow(BuildContext context) {
    return const Text(
      """Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.""",
      style: TextStyle(overflow: TextOverflow.clip),
    );
  }

  Widget _tagRow() {
    return Row(
      children: [
        Expanded(
          // 70 %
          flex: 65,
          child: Wrap(
            children: [
              _buildTag("Förderbot", Colors.red),
              _buildTag("Lernbuddy", Colors.green),
              _buildTag("123", Colors.yellow),
            ],
          ),
        ),
        Flexible(
          // 30 %
          flex: 30,
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
                    Icon(Icons.dynamic_feed_outlined, size: iconSize),
                    SizedBox(width: 5.0),
                    Text("5 / 7")
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 0),
      child: GestureDetector(
        onTap: () {
          // This is where we might set a filter in the future
        },
        child: Chip(
          backgroundColor: color.withOpacity(0.5),
          label: Text(label),
        ),
      ),
    );
  }
}
