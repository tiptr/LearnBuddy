import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';

// class SubTasksList extends StatefulWidget {
//   const SubTasksList({Key? key}) : super(key: key);
//
//   @override
//   State<SubTasksList> createState() => _SubTasksListState();
// }
//
// class _SubTasksListState extends State<SubTasksList> {
//   final ScrollController scrollController;
//
//   _SubTasksListState({required this.scrollController})
//

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
          // itemExtent: 110,
          itemBuilder: (BuildContext context, int index) {
            return TaskCard(
              isSubTaskCard: true,
              task: ListReadTaskDto(
                id: index,
                title: 'jdhlsf',
                done: false,
                categoryColor: Colors.lightBlue,
                subTaskCount: 0,
                finishedSubTaskCount: 0,
                isQueued: false,
                keywords: [],
                dueDate: null,
                remainingTimeEstimation: null,
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
                builder: (context) => const TaskAddScreen(),
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                    ),
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
