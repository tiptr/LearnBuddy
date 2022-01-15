import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
import 'package:learning_app/features/tasks/widgets/task_add_app_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';

/// This screen is used for both creating and editing tasks
///
/// To use this as create-screen, no existingTask is to be passed.
class TaskDetailsScreen extends StatefulWidget {
  final Task? existingTask;

  const TaskDetailsScreen({
    Key? key,
    this.existingTask,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // This will be used, when this screen is expanded to the edit screen
  DateTime? selectedDueDate = DateTime.now();
  Duration? selectedTimeEstimate;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AddTaskCubit>(context).addTaskAttribute(CreateTaskDto(
      parentId: const drift.Value(null),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:
    BlocProvider.of<AddTaskCubit>(context).addTaskAttribute(CreateTaskDto(
      dueDate: drift.Value(selectedDueDate),
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
                  onChange: (DateTime? datetime) {
                    // TODO: remove setState here?
                    setState(() {
                      selectedDueDate = datetime;
                    });
                    BlocProvider.of<AddTaskCubit>(context)
                        .addTaskAttribute(CreateTaskDto(
                      dueDate: drift.Value(datetime),
                    ));
                  },
                ),
                const SizedBox(height: 20.0),
                DurationInputField(
                  preselectedDuration: selectedTimeEstimate,
                  onChange: (Duration? duration) {
                    // TODO: remove setState here?
                    setState(() {
                      selectedTimeEstimate = duration;
                    });
                    BlocProvider.of<AddTaskCubit>(context)
                        .addTaskAttribute(CreateTaskDto(
                      estimatedTime: drift.Value(duration),
                    ));
                  },
                ),
                const SizedBox(height: 20.0),
                TextInputField(
                  label: "Beschreibung",
                  hintText: "Text eingeben",
                  iconData: Icons.description_outlined,
                  textController: _descriptionController,
                  onChanged: (text) async {
                    BlocProvider.of<AddTaskCubit>(context)
                        .addTaskAttribute(CreateTaskDto(
                      description: drift.Value(text),
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
