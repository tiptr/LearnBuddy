import 'package:flutter/material.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';

class DateInputField extends StatefulWidget {
  final Function onChange;
  final DateTime? preselectedDate;

  const DateInputField({
    Key? key,
    required this.onChange,
    required this.preselectedDate,
  }) : super(key: key);

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final TextEditingController _textEditingController = TextEditingController();
  DateTime? date;

  @override
  void initState() {
    super.initState();
    date = widget.preselectedDate;
    _textEditingController.text = date.formatDependingOnCurrentDate(ifNull: '');
    // This listener is used for disallowing text selection
    _textEditingController.addListener(() {
      _textEditingController.selection =
          const TextSelection.collapsed(offset: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 50, now.month, now.day);
    var lastDate = DateTime(now.year + 50, now.month, now.day);

    return TextField(
      onTap: () async {
        // Unfocus, so that no keyboard will be opened for the textfield
        FocusManager.instance.primaryFocus?.unfocus();

        var picked = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked != null) {
          // Change the text content
          _textEditingController.text =
              picked.formatDependingOnCurrentDate(ifNull: '');
          // Change the state, so the widget will re-render
          setState(() {
            date = picked;
          });
          // Notify Listener:
          widget.onChange(date);
        }
      },
      // The following attributes are used for disallowing text selection
      mouseCursor: null,
      showCursor: false,
      toolbarOptions: const ToolbarOptions(), // empty -> no toolbar
      readOnly: true,

      controller: _textEditingController,
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
        prefixIcon: const Icon(
          Icons.today_outlined,
          color: Color(0xFF636573),
        ),
        suffixIcon: date != null
            ? IconButton(
                icon: const Icon(
                  Icons.backspace_outlined,
                  color: Color(0xFF636573),
                ),
                onPressed: () {
                  // Change the text content
                  _textEditingController.text = '';
                  // Change the state, so the widget will re-render
                  setState(() {
                    date = null;
                  });
                  // Notify Listener:
                  widget.onChange(date);
                },
              )
            : null,
        label: const Text(
          "Fälligkeitsdatum",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: 'Datum auswählen',
        hintStyle: const TextStyle(color: Color(0xFF949597)),
      ),
    );
  }
}
