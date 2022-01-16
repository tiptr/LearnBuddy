import 'dart:async';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
import 'package:learning_app/features/tasks/widgets/task_details_app_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';

final DateTime? preSelectedDueDate = DateTime.now();
const Duration? preSelectedTimeEstimate = null;
const String preSelectedDescription = '';
const List<DetailsReadTaskDto> preSelectedSubtasks = [];

class TaskDetailsScreen extends StatelessWidget {
  final int? existingTaskId;
  final int? parentId;

  const TaskDetailsScreen({
    Key? key,
    this.existingTaskId,
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
        existingTaskId: existingTaskId,
        parentId: parentId,
      ),
    );
  }
}

/// This screen is used for both creating and editing tasks
///
/// To use this as create-screen, no existingTask is to be passed.
class TaskDetailsScreenMainElement extends StatefulWidget {
  final int? existingTaskId;
  final int? parentId;

  const TaskDetailsScreenMainElement({
    Key? key,
    this.existingTaskId,
    this.parentId, // if null -> top level task
  }) : super(key: key);

  @override
  State<TaskDetailsScreenMainElement> createState() =>
      _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreenMainElement> {
  final ScrollController _scrollController = ScrollController();

  Stream<DetailsReadTaskDto?>? _existingTaskStream;

  @override
  void initState() {
    super.initState();

    // Load the stream and introduce a listener, if opened for editing a task
    if (widget.existingTaskId != null) {
      int id = widget.existingTaskId as int;
      // Load the detail-dto stream for the selected card:
      _existingTaskStream = BlocProvider.of<TasksCubit>(context)
          .getDetailsDtoForTopLevelTaskIdStream(id);

      // Screen is used to update an existing task
      BlocProvider.of<AlterTaskCubit>(context).startAlteringExistingTask(id);
    } else {
      // Screen is used to create a new task
      BlocProvider.of<AlterTaskCubit>(context)
          .startNewTaskConstruction(widget.parentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_existingTaskStream == null) {
      // Create a new task

      // Set initial dueDate:
      BlocProvider.of<AlterTaskCubit>(context)
          .alterTaskAttribute(TaskManipulationDto(
        dueDate: drift.Value(preSelectedDueDate),
      ));

      return _buildTaskDetailsScreen(null);
    } else {
      // Open an existing task
      return StreamBuilder<DetailsReadTaskDto?>(
          stream: _existingTaskStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return _buildTaskDetailsScreen(null);
            }

            return _buildTaskDetailsScreen(snapshot.data);
          });
    }
  }

  Widget _buildTaskDetailsScreen(DetailsReadTaskDto? detailsDto) {
    return Scaffold(
      appBar: TaskAddAppBar(existingTask: detailsDto),
      body: Scrollbar(
        interactive: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DateInputField(
                  preselectedDate: detailsDto != null
                      ? detailsDto.dueDate
                      : preSelectedDueDate,
                  onChange: (DateTime? datetime) {
                    BlocProvider.of<AlterTaskCubit>(context)
                        .alterTaskAttribute(TaskManipulationDto(
                      dueDate: drift.Value(datetime),
                    ));
                  },
                ),
                const SizedBox(height: 20.0),
                DurationInputField(
                  preselectedDuration: detailsDto != null
                      ? detailsDto.estimatedTime
                      : preSelectedTimeEstimate,
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
                  preselectedText: detailsDto != null
                      ? (detailsDto.description ?? '')
                      : preSelectedDescription,
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

                SubTasksList(
                  scrollController: _scrollController,
                  subTasksList: detailsDto != null
                      ? detailsDto.children
                      : preSelectedSubtasks,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
