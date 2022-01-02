import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
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

  // Preselect now, because our UIs task logic requires a date to be set
  DateTime selectedDueDate = DateTime.now();
  Duration? selectedTimeEstimate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:
    BlocProvider.of<AddTaskCubit>(context).addTaskAttribute(CreateTaskDto(
      dueDate: selectedDueDate,
    ));

    return Scaffold(
      appBar: TaskAddAppBar(textController: _titleController),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DateInputField(
                selectedDate: selectedDueDate,
                onSelect: (DateTime datetime) {
                  setState(() {
                    selectedDueDate = datetime;
                  });
                  BlocProvider.of<AddTaskCubit>(context)
                      .addTaskAttribute(CreateTaskDto(
                    dueDate: datetime,
                  ));
                },
              ),
              const SizedBox(height: 20.0),
              DurationInputField(
                selectedDuration: selectedTimeEstimate,
                onSelect: (Duration duration) {
                  setState(() {
                    selectedTimeEstimate = duration;
                  });
                  BlocProvider.of<AddTaskCubit>(context)
                      .addTaskAttribute(CreateTaskDto(
                    estimatedTime: duration.inMinutes,
                  ));
                },
              ),
              const SizedBox(height: 20.0),
              TextInputField(
                label: "Beschreibung",
                hintText: "Text eingeben",
                iconData: Icons.book_outlined,
                textController: _descriptionController,
                onChanged: (text) async {
                  BlocProvider.of<AddTaskCubit>(context)
                      .addTaskAttribute(CreateTaskDto(
                    description: text,
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
