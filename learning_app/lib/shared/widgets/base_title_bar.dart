import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class BaseTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const BaseTitleBar({
    Key? key,
    required this.title,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Colors.transparent,
      elevation: 0.0,
      foregroundColor: const Color(0xFF636573),
      title: Text(
        title,
        style: Theme.of(context).textTheme.mainPageTitleStyle,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(mainScreensAppBarHeight);
}
