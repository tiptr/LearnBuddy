import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
import 'package:learning_app/features/tasks/widgets/task_details_app_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';

class TaskDetailsScreen extends StatelessWidget {
  final DetailsReadTaskDto? existingTask;
  final int? parentId;

  const TaskDetailsScreen({
    Key? key,
    this.existingTask,
    this.parentId, // if null -> top level task
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocProvider<AlterTaskCubit>(
       lazy: true,
       create: (context) {
     return AlterTaskCubit();
   },
    child: TaskDetailsScreenMainElement(
      existingTask: existingTask,
      parentId: parentId,
    ),
   );
  }
}

/// This screen is used for both creating and editing tasks
///
/// To use this as create-screen, no existingTask is to be passed.
class TaskDetailsScreenMainElement extends StatefulWidget {
  final DetailsReadTaskDto? existingTask;
  final int? parentId;

  const TaskDetailsScreenMainElement({
    Key? key,
    this.existingTask,
    this.parentId, // if null -> top level task
  }) : super(key: key);

  @override
  State<TaskDetailsScreenMainElement> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreenMainElement> {
  final ScrollController _scrollController = ScrollController();

  // This will be used, when this screen is expanded to the edit screen
  DateTime? preSelectedDueDate;
  Duration? preSelectedTimeEstimate;
  late String preSelectedDescription;

  @override
  void initState() {
    super.initState();

    if (widget.existingTask == null) {
      // Screen is used to create a new task
      BlocProvider.of<AlterTaskCubit>(context)
          .startNewTaskConstruction(widget.parentId);
    } else {
      // Screen is used to update an existing task
      final existingTask = widget.existingTask as DetailsReadTaskDto;
      BlocProvider.of<AlterTaskCubit>(context)
          .startAlteringExistingTask(existingTask.id);
    }

    // Define initial values:
    preSelectedDueDate = widget.existingTask != null
        ? widget.existingTask?.dueDate
        : DateTime.now();
    preSelectedTimeEstimate = widget.existingTask?.estimatedTime;
    preSelectedDescription = widget.existingTask?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Set initial dueDate:
    BlocProvider.of<AlterTaskCubit>(context)
        .alterTaskAttribute(TaskManipulationDto(
      dueDate: drift.Value(preSelectedDueDate),
    ));

    return Scaffold(
        appBar: TaskAddAppBar(existingTask: widget.existingTask),
        body: Scrollbar(
          interactive: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DateInputField(
                    preselectedDate: preSelectedDueDate,
                    onChange: (DateTime? datetime) {
                      BlocProvider.of<AlterTaskCubit>(context)
                          .alterTaskAttribute(TaskManipulationDto(
                        dueDate: drift.Value(datetime),
                      ));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DurationInputField(
                    preselectedDuration: preSelectedTimeEstimate,
                    onChange: (Duration? duration) {
                      BlocProvider.of<AlterTaskCubit>(context)
                          .alterTaskAttribute(TaskManipulationDto(
                        estimatedTime: drift.Value(duration),
                      ));
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextInputField(
                    label: "Beschreibung",
                    hintText: "Text eingeben",
                    iconData: Icons.description_outlined,
                    onChange: (text) async {
                      BlocProvider.of<AlterTaskCubit>(context)
                          .alterTaskAttribute(TaskManipulationDto(
                        description: drift.Value(text),
                      ));
                    },
                    preselectedText: preSelectedDescription,
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
