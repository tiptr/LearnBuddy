import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';

class SettingsScreenBaseTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsScreenBaseTemplate({
    Key? key,
    required this.title,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:

    return Scaffold(
      appBar: GoBackTitleBar(
        title: title,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: children,
      ),
    );
  }
}
