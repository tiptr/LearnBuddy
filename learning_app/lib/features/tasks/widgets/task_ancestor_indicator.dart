import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';

class TaskAncestorIndicator extends StatelessWidget {
  final List<String> ancestors;
  final Color? categoryColor;
  final int? topLevelId;

  const TaskAncestorIndicator({
    Key? key,
    required this.topLevelId,
    required this.ancestors,
    required this.categoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String topLevelParent = ancestors.first;
    final List<String> subAncestors = ancestors.sublist(1);

    return InkWell(
      onTap: () async {
        if (topLevelId != null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                existingTaskId: topLevelId,
                topLevelParentId: topLevelId,
              ),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 2,
              right: 10,
            ),
            child: ColorIndicator(
                color: categoryColor ??
                    Theme.of(context).colorScheme.noCategoryDefaultColor,
                height: 35,
                width: 10),
          ),
          Text(
            'Gehört\nzu:',
            style: Theme.of(context).textTheme.textStyle2.withBold,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    topLevelParent,
                    style: Theme.of(context).textTheme.textStyle2.withBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (String ancestor in subAncestors)
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.subdirectory_arrow_right_outlined,
                          color: Theme.of(context).colorScheme.onBackgroundSoft,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            ancestor,
                            style: Theme.of(context).textTheme.textStyle3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
