import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/util/formatting.dart';

class DurationInputField extends StatelessWidget {
  final Function onSelect;
  final Duration? selectedDuration;

  const DurationInputField({
    Key? key,
    required this.onSelect,
    required this.selectedDuration,
  }) : super(key: key);

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
          onSelect(resultingDuration);
        }
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            prefixIcon: const Icon(Icons.timer_outlined),
            label: const Text("Zeitschätzung"),
            hintText: Formatting.formatDuration(
              selectedDuration,
              "Dauer auswählen",
            ),
          ),
        ),
      ),
    );
  }
}
