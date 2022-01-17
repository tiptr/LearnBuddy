import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class BaseTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseTitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Colors.transparent,
      elevation: 0.0,
      foregroundColor: const Color(0xFF636573),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
