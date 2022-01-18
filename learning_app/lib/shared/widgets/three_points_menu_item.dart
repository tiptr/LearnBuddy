import 'package:flutter/material.dart';

class ThreePointsMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;

  const ThreePointsMenuItem({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListTile(
        title: Text(title),
        trailing: Icon(
          iconData,
          color: const Color(0xFF636573),
        ),
      ),
    );
  }
}
