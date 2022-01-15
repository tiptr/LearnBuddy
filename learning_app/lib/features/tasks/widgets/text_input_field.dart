import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? iconData;
  final TextEditingController textController;
  final Function(String)? onChanged;

  const TextInputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.iconData,
    required this.textController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.textStyle2,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: Theme.of(context).colorScheme.onBackground,
              )
            : null,
        label: Text(
          label,
          // Same TextStyle with bold text. Inherited from the textfield,
          // so the TextStyle is not explicitly defined with a constant
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: hintText,
        hintStyle:
            // Same TextStyle with a softer color. Inherited from the textfield,
            // so the TextStyle is not explicitly defined with a constant
            TextStyle(color: Theme.of(context).colorScheme.onBackgroundSoft),
      ),
      maxLines: null, // no limit
      controller: textController,
      onChanged: onChanged,
    );
  }
}
