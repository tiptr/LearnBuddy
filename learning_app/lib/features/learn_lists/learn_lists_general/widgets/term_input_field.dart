import 'package:flutter/material.dart';

class TermInputField extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final TextEditingController textController;
  final int? id;
  final Function(String, int) onChange;

  const TermInputField({
    Key? key,
    required this.hintText,
    required this.iconData,
    required this.textController,
    this.id,
    required this.onChange,
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
      onChanged: (text) => onChange(text, id ?? 0),
    );
  }
}
