import 'package:flutter/material.dart';

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
    return SizedBox(
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
                color: Theme.of(context).primaryColor,
                value: progress,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Text(
              "${(100 * progress).round()} %",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
