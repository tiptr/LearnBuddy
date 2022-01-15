import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class BaseTitleBar extends StatelessWidget {
  final String title;

  const BaseTitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.mainPageTitleStyle,
    );
  }
}
