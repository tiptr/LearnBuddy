import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const ColorIndicator({
    Key? key,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
