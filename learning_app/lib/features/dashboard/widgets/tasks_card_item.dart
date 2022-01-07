import 'package:flutter/material.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/util/logger.dart';

class TasksCardItem extends StatelessWidget {
  final ListReadTaskDto task;

  const TasksCardItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: CardElevation.high,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 12.5, color: task.categoryColor),
          ),
          color: Colors.white,
        ),
        height: 75.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title and Description
            Expanded(
              flex: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationThickness: 2.0,
                      fontSize: 16.0,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const Text(
                    // TODO
                    "Task Description missing in model",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.open_in_new_outlined,
                      color: Colors.purple,
                      size: 24.0,
                    ),
                    onPressed: () {
                      logger.d(
                        // TODO: Will be done in #57
                        "Handle click on Icon open_in_new for task ${task.title}",
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
