import 'package:flutter/material.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

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
        prefixIcon: Icon(
          Icons.today_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: date != null
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onBackground,
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
        label: Text(
          "Fälligkeitsdatum",
          style: Theme.of(context).textTheme.textStyle2.withBold,
        ),
        hintText: 'Datum auswählen',
        hintStyle:
            // Same TextStyle with softer color. Inherited from the textfield,
            // so the TextStyle is not explicitly defined with a constant
            TextStyle(color: Theme.of(context).colorScheme.onBackgroundSoft),
      ),
    );
  }
}
