import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

class TaskUsedTimeIndicator extends StatelessWidget {
  final Duration usedTime;

  const TaskUsedTimeIndicator({
    Key? key,
    required this.usedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          color: Theme.of(context).colorScheme.onBackgroundSoft,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Aufgewendete Zeit:',
          style: Theme.of(context).textTheme.textStyle3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          usedTime.toListViewFormat(),
          style: Theme.of(context)
              .textTheme
              .textStyle3
              .withOnBackgroundHard
              .withBold,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
