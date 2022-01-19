import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class GoBackTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? textStyle;
  final Function? onExit;
  final Widget? actionWidget;

  const GoBackTitleBar({
    Key? key,
    required this.title,
    this.textStyle,
    this.onExit,
    this.actionWidget,
  }) : super(key: key);

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
                    if (onExit != null) onExit!();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onBackgroundHard,
                  ),
                  iconSize: 30,
                  color: Theme.of(context).colorScheme.onBackgroundHard,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle1
                        .withBold
                        .withOnBackgroundHard,
                  ),
                ),
                if (actionWidget != null) actionWidget!,
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
