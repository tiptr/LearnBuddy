import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/widgets/create_sub_task_card.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';

class SubTasksList extends StatefulWidget {
  final List<DetailsReadTaskDto> subTasksList;

  const SubTasksList({
    Key? key,
    this.subTasksList = const [],
  }) : super(key: key);

  @override
  State<SubTasksList> createState() => _SubTasksListState();
}

class _SubTasksListState extends State<SubTasksList> {
  late List<DetailsReadTaskDto?> subTasksList;

  @override
  void initState() {
    super.initState();
    subTasksList = List<DetailsReadTaskDto?>.from(widget.subTasksList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          // Use this physics, so that the scrolling of the parent is used instead
          // -> we want the whole view to be scrollable rather than just the subtasks
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: subTasksList.length,
          // itemExtent: 95,
          itemBuilder: (BuildContext context, int index) {
            DetailsReadTaskDto? detailsDto = subTasksList[index];

            if (detailsDto == null) {
              // Null means to build a creation-card for a new subtask
              return const CreateSubTaskCard();
            } else {
              DetailsReadTaskDto actualDetailsDto = detailsDto;
              return TaskCard(
                isSubTaskCard: true,
                task: ListReadTaskDto.fromDetailsReadTasksDto(actualDetailsDto),
              );
            }
          },
        ),
        InkWell(
          onTap: () {
            //TODO

            setState(() {
              subTasksList.add(null);
            });

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const TaskDetailsScreen(),
            //   ),
            // );
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
