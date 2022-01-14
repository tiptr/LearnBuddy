import 'package:flutter/material.dart';

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
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: const Color(0xFF636573),
              )
            : null,
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF949597)),
      ),
      maxLines: null, // no limit
      controller: textController,
      onChanged: onChanged,
    );
  }
}
