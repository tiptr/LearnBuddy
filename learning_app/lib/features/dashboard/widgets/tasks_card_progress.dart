import 'package:flutter/material.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_process_indicator.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';

class TasksCardProgress extends StatelessWidget {
  final double progress;

  const TasksCardProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
      ),
      elevation: CardElevation.high,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        height: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 30,
              child: Center(
                child: TasksProcessIndicator(progress: progress, size: 85.0),
              ),
            ),
            Expanded(
              flex: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Hourglass and Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.hourglass_top_outlined,
                        size: 40.0,
                        color: Colors.grey,
                      ),
                      Text(
                        "Heutiger Restaufwand:\n2h 30min",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  // Color Indicators and Done / Open
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ColorIndicator(
                        color: Theme.of(context).primaryColor,
                        height: 10.0,
                        width: 30.0,
                      ),
                      const Text(
                        "4 Erledigt",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const ColorIndicator(
                        color: Colors.grey,
                        height: 10.0,
                        width: 30.0,
                      ),
                      const Text(
                        "3 Offen",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
