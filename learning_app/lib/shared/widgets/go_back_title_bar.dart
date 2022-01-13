import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class GoBackTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle textStyle;

  const GoBackTitleBar(
      {Key? key,
      required this.title,
      this.textStyle = const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
