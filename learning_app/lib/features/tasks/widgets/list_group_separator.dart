import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class ListGroupSeparator extends StatelessWidget {
  final String _content;
  final bool _highlight;

  const ListGroupSeparator({
    Key? key,
    required String content,
    required bool highlight,
  })  : _content = content,
        _highlight = highlight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.textStyle4;
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4.0),
      label: Text(
        _content,
        textAlign: TextAlign.center,
        style: _highlight ? style.withOnSecondary : style.withOnBackgroundSoft,
      ),
      backgroundColor: _highlight
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.subtleBackgroundGrey,
    );
  }
}
