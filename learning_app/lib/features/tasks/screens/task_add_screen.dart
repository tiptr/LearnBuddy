import 'package:flutter/material.dart';
import 'package:learning_app/features/tasks/widgets/task_add_app_bar.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({Key? key}) : super(key: key);

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _nameController = TextEditingController();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textController: _nameController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _generateTextField(context: context),
              const SizedBox(height: 20.0),
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
              _generateTextField(context: context),
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
