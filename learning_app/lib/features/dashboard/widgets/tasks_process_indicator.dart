import 'package:flutter/material.dart';

class TasksProcessIndicator extends StatelessWidget {
  final double progress;
  final double size;

  TasksProcessIndicator({
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
                    // TODO: to be structured in the theme-issue:
                    // color: Theme.of(context).primaryColor,
                    color: const Color(0xFF39BBD1),
                    value: progress,
                    // TODO: to be structured in the theme-issue:
                    backgroundColor: const Color(0xFFF2EAFB),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${(100 * progress).round()} %",
                  style: const TextStyle(
                    // TODO: to be structured in the theme-issue:
                    color: Color(0xFF949597),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
