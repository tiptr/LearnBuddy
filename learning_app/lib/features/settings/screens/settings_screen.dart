import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

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
      appBar: const GoBackTitleBar(
        title: "Persönliche Daten Langer Test",
        backTo: "Einstellungen",
      ),
      body: Scrollbar(
        interactive: true,
        controller: _scrollController,
        child: SingleChildScrollView(
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
                      estimatedTime: duration,
                    ));
                  },
                ),
                const SizedBox(height: 20.0),
                TextInputField(
                  label: "SETTINGS",
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
                // Subtasks
                const SizedBox(height: 20.0),
                Row(
                  children: const [
                    Text(
                      "Unteraufgaben",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Color(0xFF636573),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                SubTasksList(scrollController: _scrollController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
