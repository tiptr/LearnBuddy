import 'package:flutter/material.dart';

class TermInputField extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final TextEditingController textController;

  const TermInputField({
    Key? key,
    required this.hintText,
    required this.iconData,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
        prefixIcon: iconData != null ? Icon(iconData) : null,
        hintText: hintText,
      ),
      controller: textController,
      autofocus: true,
    );
  }
}
