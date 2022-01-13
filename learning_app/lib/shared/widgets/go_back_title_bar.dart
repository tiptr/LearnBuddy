import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class GoBackTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? backTo;
  final TextStyle textStyle;

  const GoBackTitleBar(
      {Key? key,
      required this.title,
      this.backTo,
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
              // crossAxisAlignment: CrossAxisAlignment.center,
              // textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                // Two alternatives necessary for different spacings :annoyed:

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      Text(
                        backTo ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                // TextButton.icon(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   icon: const Icon(
                //     Icons.arrow_back,
                //     size: 30,
                //   ),
                //   label: Text(
                //     backTo ?? "",
                //     style: const TextStyle(
                //       fontSize: 18,
                //     ),
                //   ),
                //   style: TextButton.styleFrom(
                //     primary: Theme.of(context).colorScheme.primary,
                //     // padding: EdgeInsets.zero,
                //   ),
                // ),
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
