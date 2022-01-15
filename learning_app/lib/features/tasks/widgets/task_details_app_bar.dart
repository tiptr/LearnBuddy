import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:drift/drift.dart' as drift;
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/util/logger.dart';

class TaskAddAppBar extends StatefulWidget implements PreferredSizeWidget {
  final DetailsReadTaskDto? existingTask;

  const TaskAddAppBar({
    Key? key,
    this.existingTask,
  }) : super(key: key);

  @override
  State<TaskAddAppBar> createState() => _TaskAddAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class _TaskAddAppBarState extends State<TaskAddAppBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial value, if present
    _textEditingController.text = widget.existingTask?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Name der Aufgabe',
                      border: InputBorder.none,
                    ),
                    controller: _textEditingController,
                    onChanged: (text) async {
                      BlocProvider.of<AlterTaskCubit>(context)
                          .alterTaskAttribute(TaskManipulationDto(
                        title: drift.Value(text),
                      ));
                    },
                    autofocus: widget.existingTask == null,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final cubit = BlocProvider.of<AlterTaskCubit>(context);
                    // validate required fields:
                    if (!cubit.validateTaskConstruction()) {
                      // Not ready to save! Inform the user and continue
                      final missingFieldsDescr =
                          cubit.getMissingFieldsDescription();
                      logger.d(
                          'The task is not ready to be saved! Description: $missingFieldsDescr');
                      // TODO: inform the user with a SnackBar
                      return;
                    }

                    await BlocProvider.of<AlterTaskCubit>(context).saveTask();

                    // Exit task details screen
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.save_outlined,
                    color: Color(0xFF636573),
                  ),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
