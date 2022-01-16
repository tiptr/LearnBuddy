import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget content;
  final Widget titleBar;

  const BaseLayout({Key? key, required this.titleBar, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: titleBar,
          ),
          Expanded(child: content),
        ],
      ),
    );
  }
}
