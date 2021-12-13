import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/widgets/task_add_app_bar.dart';
import 'package:duration_picker/duration_picker.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({Key? key}) : super(key: key);

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _titleController = TextEditingController();

  DateTime? selectedDate;
  Duration? selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textController: _titleController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _generateDateField(
                selectedDate: selectedDate,
                context: context,
                onSelect: (DateTime datetime) {
                  setState(() {
                    selectedDate = datetime;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              _generateDurationField(
                selectedDuration: selectedDuration,
                context: context,
                onSelect: (Duration duration) {
                  setState(() {
                    selectedDuration = duration;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              _generateTextField(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateTextField({required BuildContext context}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        prefixIcon: const Icon(Icons.book_outlined),
        label: const Text("Beschreibung"),
        hintText: "Text eingeben",
      ),
    );
  }

  Widget _generateDurationField({
    required Duration? selectedDuration,
    required BuildContext context,
    required Function onSelect,
  }) {
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
            hintText: selectedDuration == null
                ? "Dauer auswählen"
                : selectedDuration.toString(),
          ),
        ),
      ),
    );
  }

  Widget _generateDateField({
    required DateTime? selectedDate,
    required BuildContext context,
    required Function onSelect,
  }) {
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
            hintText: selectedDate == null
                ? "Datum auswählen"
                : selectedDate.toString(),
          ),
        ),
      ),
    );
  }
}
