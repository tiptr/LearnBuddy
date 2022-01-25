import 'package:flutter/material.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';

class LearnListDetailListViewItem extends StatefulWidget {
  final String word;
  const LearnListDetailListViewItem({Key? key, required this.word})
      : super(key: key);

  @override
  State<LearnListDetailListViewItem> createState() =>
      _LearnListDetailListViewItemState();
}

class _LearnListDetailListViewItemState
    extends State<LearnListDetailListViewItem> {
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
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _obscureText ? "*****" : widget.word,
              ),
              IconButton(
                icon: gradientIcon(
                  iconData:
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                  context: context,
                ),
                onPressed: _toggle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
