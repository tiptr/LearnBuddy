import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

// TODO: combine into generic appbar
class LeisureOverviewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
                  child: Text(categoryTitle,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .textStyle1
                          .withBold
                          .withOnBackgroundHard),
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
