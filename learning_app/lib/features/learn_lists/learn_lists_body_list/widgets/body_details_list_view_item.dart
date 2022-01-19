import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class LearningAidBodyDetailsListViewItem extends StatefulWidget {
  final String text;
  final String word;
  const LearningAidBodyDetailsListViewItem(
      {Key? key, required this.text, required this.word})
      : super(key: key);

  @override
  State<LearningAidBodyDetailsListViewItem> createState() =>
      _LearningAidBodyDetailsListViewItemState();
}

class _LearningAidBodyDetailsListViewItemState
    extends State<LearningAidBodyDetailsListViewItem> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.text,
              style:
                  Theme.of(context).textTheme.textStyle2.withOnBackgroundHard,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _obscureText ? "*****" : widget.word,
              ),
              IconButton(
                  icon: _obscureText
                      ? Icon(Icons.visibility,
                          color: Theme.of(context).colorScheme.onBackgroundHard)
                      : Icon(Icons.visibility_off,
                          color:
                              Theme.of(context).colorScheme.onBackgroundHard),
                  onPressed: _toggle),
            ],
          ),
        ),
      ],
    );
  }
}
