import 'package:flutter/material.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';

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
      color: Theme.of(context).colorScheme.cardColor,
      elevation: BasicCard.elevation.high,
      shadowColor: Theme.of(context).colorScheme.shadowColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              // same width of category color bar as borderradius
              width: BasicCard.borderRadius,
              color: task.categoryColor ??
                  Theme.of(context).colorScheme.noCategoryDefaultColor,
            ),
          ),
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
                    style: Theme.of(context)
                        .textTheme
                        .textStyle2
                        .withBold
                        .withOnBackgroundHard,
                    maxLines: 2,
                  ),
                  Text(
                    task.keywords.join(", "),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle4
                        .withOnBackgroundSoft,
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
                    icon: gradientIcon(
                      iconData: Icons.open_in_new_outlined,
                      context: context,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(
                            existingTaskId: task.id,
                            topLevelParentId: task.topLevelParentId,
                          ),
                        ),
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
