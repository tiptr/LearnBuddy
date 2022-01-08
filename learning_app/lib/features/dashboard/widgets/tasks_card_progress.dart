import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/dashboard/widgets/tasks_process_indicator.dart';
import 'package:learning_app/shared/widgets/color_indicator.dart';

class TasksCardProgress extends StatelessWidget {
  final double progress;

  final horizontalCardPadding = 10.0;
  final processIndicatorFlexPortion = 40;

  const TasksCardProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: _ProgressBarCardShape(
        borderRadius: 12.5,
        circleRadius: 72.5,
        // The Container that holds the cards content has a horizontal padding of 10
        horizontalCardPadding: horizontalCardPadding,
        // Check the flex amount of the Expanded, which the TaskProcessIndicator
        // is contained in
        flexPortion: processIndicatorFlexPortion / 100,
      ),
      elevation: CardElevation.high,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: horizontalCardPadding,
        ),
        height: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: processIndicatorFlexPortion,
              child: Center(
                child: TasksProcessIndicator(progress: progress, size: 100.0),
              ),
            ),
            Expanded(
              flex: 60,
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

class _ProgressBarCardShape extends ShapeBorder {
  final double circleRadius;
  final double borderRadius;
  final double horizontalCardPadding;
  final double flexPortion;

  const _ProgressBarCardShape({
    required this.circleRadius,
    required this.borderRadius,
    required this.horizontalCardPadding,
    required this.flexPortion,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);

    double roundedWidth = rect.width - borderRadius;
    double roundedHeight = rect.height - borderRadius;
    double circleCenterX =
        (rect.width * flexPortion / 2) + (horizontalCardPadding / 2);
    double circleCenterY = rect.height / 2;

    var basePath = Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy + borderRadius)
      ..lineTo(rect.topLeft.dx, rect.topLeft.dy + roundedHeight)

      // Rectangle Bottom Left Corner
      ..arcTo(
        Rect.fromLTWH(
          rect.topLeft.dx,
          rect.topLeft.dy + roundedHeight,
          borderRadius,
          borderRadius,
        ),
        -pi,
        -pi / 2,
        false,
      )
      // Move to Bottom Right
      ..lineTo(
        rect.topLeft.dx + roundedWidth,
        rect.topLeft.dy + roundedHeight + borderRadius,
      )

      // Rectangle Bottom Right Corner
      ..arcTo(
        Rect.fromLTWH(
          rect.topLeft.dx + roundedWidth,
          rect.topLeft.dy + roundedHeight,
          borderRadius,
          borderRadius,
        ),
        -3 * pi / 2,
        -pi / 2,
        false,
      )
      // Move to Top Right
      ..lineTo(
        rect.topLeft.dx + roundedWidth + borderRadius,
        rect.topLeft.dy + borderRadius,
      )

      // Rectangle Top Right Corner
      ..arcTo(
        Rect.fromLTWH(
          rect.topLeft.dx + roundedWidth,
          rect.topLeft.dy,
          borderRadius,
          borderRadius,
        ),
        0,
        -pi / 2,
        false,
      )
      // Move to Top Left
      ..lineTo(
        rect.topLeft.dx + roundedWidth,
        rect.topLeft.dy,
      )

      // Rectangle Top Left Corner
      ..arcTo(
        Rect.fromLTWH(
          rect.topLeft.dx,
          rect.topLeft.dy,
          borderRadius,
          borderRadius,
        ),
        -pi / 2,
        -pi / 2,
        false,
      )
      ..close();

    // Add the path for our circular notch
    var circle = Rect.fromCircle(
      center: Offset(circleCenterX, circleCenterY),
      radius: circleRadius,
    );

    var circlePath = Path();
    circlePath.addOval(circle);
    circlePath.close();

    // Build the union of the base card and the new circle path
    return Path.combine(PathOperation.union, basePath, circlePath);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError(
      "Scaling is not implemented for the task card progress widget.",
    );
  }
}
