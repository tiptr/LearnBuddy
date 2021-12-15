import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? iconData;
  final TextEditingController textController;

  const TextInputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.iconData,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        prefixIcon: iconData != null ? Icon(iconData) : null,
        label: Text(label),
        hintText: hintText,
      ),
      controller: textController,
    );
  }
}
