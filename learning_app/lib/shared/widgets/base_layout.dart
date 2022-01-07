import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget content;
  final Widget titleBar;

  const BaseLayout({Key? key, required this.titleBar, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: titleBar,
        ),
        Expanded(child: content),
      ],
    );
  }
}
