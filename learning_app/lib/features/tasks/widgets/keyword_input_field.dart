import 'package:flutter/material.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';

class KeyWordInputField extends StatelessWidget {
  final Function onSelect;
  final List<ReadKeyWordDto> selectedKeywords;
  final List<ReadKeyWordDto> options;

  const KeyWordInputField({
    Key? key,
    required this.onSelect,
    required this.selectedKeywords,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        // Unfocus, so that no keyboard will be opened for the textfield
        FocusManager.instance.primaryFocus?.unfocus();

        // var picked = await showDatePicker(
        //   context: context,
        //   initialDate: now,
        //   firstDate: firstDate,
        //   lastDate: lastDate,
        // );
        // if (picked != null) {
        //   // Change the text content
        //   _textEditingController.text =
        //       picked.formatDependingOnCurrentDate(ifNull: '');
        //   // Change the state, so the widget will re-render
        //   setState(() {
        //     date = picked;
        //   });
        //   // Notify Listener:
        //   widget.onChange(date);
        // }
      },
      // The following attributes are used for disallowing text selection
      mouseCursor: null,
      showCursor: false,
      toolbarOptions: const ToolbarOptions(), // empty -> no toolbar
      readOnly: true,
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
        prefixIcon: const Icon(
          Icons.new_label_outlined,
          color: Color(0xFF636573),
        ),
        label: const Text(
          "Schlagwörter",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: 'Schlagwörter auswählen',
        hintStyle: const TextStyle(color: Color(0xFF949597)),
      ),
    );
  }
}
