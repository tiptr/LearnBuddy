import 'package:flutter/material.dart';

class CategoryColorCirlce extends StatelessWidget {
  final double radius;
  final Color color;
  final Function onTap;

  const CategoryColorCirlce({
    Key? key,
    required this.radius,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double shadowFactor = radius / 20;

    return InkWell(
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              spreadRadius: shadowFactor,
              blurRadius: shadowFactor,
              offset: Offset(shadowFactor, shadowFactor),
              color: color,
            )
          ],
        ),
      ),
      onTap: () {
        onTap(color);
      },
    );
  }
}
