import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class LearnListsDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;

  const LearnListsDetailAppBar({Key? key, required this.text})
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
                ),
                Expanded(
                  child: Text(
                    text,
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
  Size get preferredSize => const Size.fromHeight(detailScreensAppBarHeight);
}
