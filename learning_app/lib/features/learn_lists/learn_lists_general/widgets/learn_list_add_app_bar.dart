import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class LearnListAddAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController textController;

  const LearnListAddAppBar({Key? key, required this.textController})
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onBackgroundHard,
                  ),
                  iconSize: 30,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Name der Aufgabe',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .textStyle2
                          .withOnBackgroundSoft
                          .withOutBold,
                      border: InputBorder.none,
                    ),
                    controller: textController,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle2
                        .withOnBackgroundHard
                        .withBold,
                    autofocus: true,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO: add cubit
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    color: Theme.of(context).colorScheme.onBackgroundHard,
                  ),
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
  Size get preferredSize => const Size.fromHeight(detailScreensAppBarHeight);
}
