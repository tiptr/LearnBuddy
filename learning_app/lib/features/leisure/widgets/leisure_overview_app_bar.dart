import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class LeisureOverviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String categoryTitle;

  const LeisureOverviewAppBar({Key? key, required this.categoryTitle})
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
                  child: Text(categoryTitle, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  onPressed: () {
                    //TODO: add search function
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    //TODO: add settings function
                  },
                  icon: const Icon(Icons.more_vert),
                  iconSize: 30,
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
