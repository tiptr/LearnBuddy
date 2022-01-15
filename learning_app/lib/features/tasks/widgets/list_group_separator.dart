import 'package:flutter/material.dart';

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
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4.0),
      label: Text(
        _content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: _highlight ? Colors.white : const Color(0xFF636573),
        ),
      ),
      backgroundColor:
          _highlight ? const Color(0xFF9E5EE1) : const Color(0xFFEAECFA),
    );
  }
}
