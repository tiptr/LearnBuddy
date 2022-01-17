import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/widgets/create_sub_task_card.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class SubTasksList extends StatefulWidget {
  final List<DetailsReadTaskDto> subTasksList;
  final bool directlyStartSubtaskCreation;

  const SubTasksList({
    Key? key,
    this.subTasksList = const [],
    this.directlyStartSubtaskCreation = false,
  }) : super(key: key);

  @override
  State<SubTasksList> createState() => _SubTasksListState();
}

class _SubTasksListState extends State<SubTasksList> {
  bool creatingModeActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.directlyStartSubtaskCreation) {
      creatingModeActive = true;
    }
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
          itemCount: widget.subTasksList.length + (creatingModeActive ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.subTasksList.length) {
              DetailsReadTaskDto detailsDto = widget.subTasksList[index];
              return TaskCard(
                isSubTaskCard: true,
                task: ListReadTaskDto.fromDetailsReadTasksDto(detailsDto),
                context: context,
              );
            } else {
              // Build card for new subtask creation
              return CreateSubTaskCard(
                onDiscard: () {
                  // Remove the creation card
                  setState(() {
                    creatingModeActive = false;
                  });
                },
                onPressEnterSubmit: (title) {
                  // When enter is used, allow the quick creation of multiple
                  // subtasks
                  // -> currentlyCreatingNewSubtask not changed on purpose
                  BlocProvider.of<AlterTaskCubit>(context)
                      .createNewSubTask(title);
                },
                onUseButtonSubmit: (title) async {
                  // When the button is used, only create one subtask
                  setState(() {
                    creatingModeActive = false;
                  });

                  BlocProvider.of<AlterTaskCubit>(context)
                      .createNewSubTask(title);
                },
              );
            }
          },
        ),
        InkWell(
          onTap: () {
            setState(() {
              creatingModeActive = true;
            });
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
