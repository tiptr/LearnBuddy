import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
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

  final ScrollController _scrollController = ScrollController();

  // This will be used, when this screen is expanded to the edit screen
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
      body: Scrollbar(
        interactive: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DateInputField(
                  preselectedDate: selectedDueDate,
                  onChange: (DateTime datetime) {
                    // TODO: remove setState here?
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
                  preselectedDuration: selectedTimeEstimate,
                  onChange: (Duration duration) {
                    // TODO: remove setState here?
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
                  label: "Beschreibung",
                  hintText: "Text eingeben",
                  // iconData: Icons.book_outlined,
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
