import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? iconData;
  final Function(String)? onChange;
  final String preselectedText;

  const TextInputField({
    Key? key,
    required this.onChange,
    required this.preselectedText,
    required this.label,
    required this.hintText,
    this.iconData,
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.preselectedText;
  }

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
        prefixIcon: widget.iconData != null
            ? Icon(
                widget.iconData,
                color: Theme.of(context).colorScheme.onBackground,
              )
            : null,
        label: Text(
          widget.label,
          style: Theme.of(context).textTheme.textStyle2.withBold,
        ),
        hintText: widget.hintText,
        hintStyle:
            // Same TextStyle with a softer color. Inherited from the textfield,
            // so the TextStyle is not explicitly defined with a constant
            TextStyle(color: Theme.of(context).colorScheme.onBackgroundSoft),
      ),
      maxLines: null, // no limit
      controller: _textEditingController,
      onChanged: widget.onChange,
    );
  }
}
