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
  State<DurationInputField> createState() => _DurationInputFieldState(

  );
}

class _DurationInputFieldState extends State<DurationInputField> {
  final TextEditingController _textEditingController = TextEditingController();
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.preselectedDuration;

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
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
      child: AbsorbPointer(
        child: TextField(
          controller: _textEditingController,
          style: const TextStyle(
            color: Color(0xFF636573),
            fontWeight: FontWeight.normal
          ),
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
            label: const Text(
                "Zeitschätzung",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
            ),
            hintText: 'Dauer auswählen',
            hintStyle: const TextStyle(
              color: Color(0xFF949597)
            ),
          ),
        ),
      ),
    );
  }
}
