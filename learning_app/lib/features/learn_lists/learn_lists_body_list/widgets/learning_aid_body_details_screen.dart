import 'package:flutter/material.dart';

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
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
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
                      ? const Icon(Icons.visibility, color: Colors.black)
                      : const Icon(Icons.visibility_off, color: Colors.black),
                  onPressed: _toggle),
            ],
          ),
        ),
      ],
    );
  }
}
