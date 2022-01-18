import 'package:flutter/material.dart';

class ScreenWithoutBottomNavbarBaseTemplate extends StatelessWidget {
  final PreferredSizeWidget titleBar;
  final Widget body;
  final FloatingActionButton? fab;
  const ScreenWithoutBottomNavbarBaseTemplate({
    Key? key,
    required this.titleBar,
    required this.body,
    this.fab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return Scaffold(
      appBar: titleBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: body,
      floatingActionButton: fab,
    );
  }
}
