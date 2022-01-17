import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

class DurationInputField extends StatefulWidget {
  final Function onChange;
  final Duration? preselectedDuration;

  const DurationInputField({
    Key? key,
    required this.onChange,
    required this.preselectedDuration,
  }) : super(key: key);

  @override
  State<DurationInputField> createState() => _DurationInputFieldState();
}

class _DurationInputFieldState extends State<DurationInputField> {
  final TextEditingController _textEditingController = TextEditingController();
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.preselectedDuration;
    _textEditingController.text = duration.format(ifNull: '');
    // This listener is used for disallowing text selection
    _textEditingController.addListener(() {
      _textEditingController.selection =
          const TextSelection.collapsed(offset: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        // Unfocus, so that no keyboard will be opened for the textfield
        FocusManager.instance.primaryFocus?.unfocus();

        var resultingDuration = await showDurationPicker(
          context: context,
          initialTime: const Duration(minutes: 30),
          snapToMins: 5,
        );

        if (resultingDuration != null) {
          // Change the text content
          _textEditingController.text = resultingDuration.format(ifNull: '');
          // Change the state, so the widget will re-render
          setState(() {
            duration = resultingDuration;
          });
          // Notify Listener:
          widget.onChange(duration);
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
          Icons.timer_outlined,
          color: Color(0xFF636573),
        ),
        suffixIcon: duration != null
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF636573),
                ),
                onPressed: () {
                  // Change the text content
                  _textEditingController.text = '';
                  // Change the state, so the widget will re-render
                  setState(() {
                    duration = null;
                  });
                  // Notify Listener:
                  widget.onChange(duration);
                },
              )
            : null,
        label: const Text(
          "Zeitschätzung",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        hintText: 'Dauer auswählen',
        hintStyle: const TextStyle(color: Color(0xFF949597)),
      ),
    );
  }
}
