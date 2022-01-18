import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class TasksProcessIndicator extends StatelessWidget {
  final double progress;
  final double size;

  const TasksProcessIndicator({
    Key? key,
    required this.progress,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
        maxHeight: size,
        maxWidth: size,
        child: SizedBox(
          height: size,
          width: size,
          child: Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    strokeWidth: 12.5,
                    color: Theme.of(context).colorScheme.tertiary,
                    value: progress,
                    backgroundColor:
                        Theme.of(context).colorScheme.subtleBackgroundGrey,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${(100 * progress).round()} %",
                  style: Theme.of(context)
                      .textTheme
                      .textStyle3
                      .withOnBackgroundSoft
                      .withBold,
                ),
              ),
            ],
          ),
        ));
  }
}
