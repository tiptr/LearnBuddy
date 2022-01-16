import 'package:flutter/material.dart';

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
      style: const TextStyle(
          color: Color(0xFF636573), fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Color(0xFF636573),
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
                color: const Color(0xFF636573),
              )
            : null,
        label: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFF949597)),
      ),
      maxLines: null, // no limit
      controller: _textEditingController,
      onChanged: widget.onChange,
    );
  }
}
