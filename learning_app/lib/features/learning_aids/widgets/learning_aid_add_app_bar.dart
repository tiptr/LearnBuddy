import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';

class LearningAidAddAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController textController;

  const LearningAidAddAppBar({Key? key, required this.textController})
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
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: 'SI-Einheiten',
                      border: InputBorder.none,
                    ),
                    controller: textController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO: add cubit
                  },
                  icon: const Icon(Icons.save),
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
