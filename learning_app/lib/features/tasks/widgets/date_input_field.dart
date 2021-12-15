import 'package:flutter/material.dart';
import 'package:learning_app/util/formatting.dart';

class DateInputField extends StatelessWidget {
  final Function onSelect;
  final DateTime? selectedDate;

  const DateInputField({
    Key? key,
    required this.onSelect,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 50, now.month, now.day);
    var lastDate = DateTime(now.year + 50, now.month, now.day);

    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: now,
          firstDate: firstDate,
          lastDate: lastDate,
        ).then((DateTime? picked) {
          if (picked != null) onSelect(picked);
        });
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            prefixIcon: const Icon(Icons.calendar_today_outlined),
            label: const Text("Fälligkeitsdatum"),
            hintText:
                Formatting.formatDateTime(selectedDate, "Datum auswählen"),
          ),
        ),
      ),
    );
  }
}
