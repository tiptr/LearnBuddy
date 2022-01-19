import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

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
        title: Text(
          title,
          style: Theme.of(context).textTheme.textStyle2.withOnBackgroundHard,
        ),
        trailing: Icon(
          iconData,
          color: Theme.of(context).colorScheme.onBackgroundHard,
        ),
      ),
    );
  }
}
