import 'package:flutter/material.dart';
import 'package:learning_app/features/tags/screens/tag_overview_screen.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/task_add_app_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({Key? key}) : super(key: key);

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? selectedDate;
  Duration? selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAddAppBar(textController: _titleController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DateInputField(
                selectedDate: selectedDate,
                onSelect: (DateTime datetime) {
                  setState(() {
                    selectedDate = datetime;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              DurationInputField(
                selectedDuration: selectedDuration,
                onSelect: (Duration duration) {
                  setState(() {
                    selectedDuration = duration;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              TextInputField(
                label: "Beschreibung",
                hintText: "Text eingeben",
                iconData: Icons.book_outlined,
                textController: _descriptionController,
              ),
              // Only for navigation to tags
              const SizedBox(height: 40.0),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagOverviewScreen(),
                  ),
                ),
                child: Ink(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Tag Overview",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
