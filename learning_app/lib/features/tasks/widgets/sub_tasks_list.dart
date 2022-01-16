import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class SubTasksList extends StatelessWidget {
  final ScrollController scrollController;

  const SubTasksList({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          // Use this physics, so that the scrolling of the parent is used instead
          // -> we want the whole view to be scrollable rather than just the subtasks
          physics: const NeverScrollableScrollPhysics(),
          // Use the scroll controller of the parent, to actually allow scrolling
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 10,
          // itemExtent: 95,
          itemBuilder: (BuildContext context, int index) {
            return TaskCard(
              isSubTaskCard: true,
              context: context,
              task: ListReadTaskDto(
                id: index,
                title: 'Gemockte Sub-Aufgabe, noch ohne jegliche Funktion',
                done: false,
                categoryColor: Colors.lightBlue,
                subTaskCount: 5,
                finishedSubTaskCount: 0,
                isQueued: false,
                keywords: const ['Hausaufgabe'],
                // keywords: const ['Hausaufgabe', 'Englisch', 'Klausurvorbereitung'],
                // keywords: const [],
                // dueDate: null
                dueDate: DateTime.now(),
                // remainingTimeEstimation: null,
                remainingTimeEstimation: const Duration(minutes: 30),
              ),
            );
          },
        ),
        InkWell(
          onTap: () {
            //TODO
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskDetailsScreen(),
              ),
            );
          },
          child: Ink(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                      size: 30.0, color: Theme.of(context).colorScheme.primary),
                  Text(
                    "Neue Unteraufgabe",
                    style: Theme.of(context)
                        .textTheme
                        .textStyle2
                        .withPrimary
                        .withBold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
