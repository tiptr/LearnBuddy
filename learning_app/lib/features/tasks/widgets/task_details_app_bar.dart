import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:drift/drift.dart' as drift;
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';

class TaskAddAppBar extends StatefulWidget implements PreferredSizeWidget {
  final DetailsReadTaskDto? existingTask;
  final Function() onSaveTask;
  final Function() onExit;
  final Function() onDelete;

  const TaskAddAppBar({
    Key? key,
    this.existingTask,
    required this.onSaveTask,
    required this.onExit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<TaskAddAppBar> createState() => _TaskAddAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class _TaskAddAppBarState extends State<TaskAddAppBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool titleEmpty = true;

  @override
  void initState() {
    super.initState();
    // Initial value, if present
    _textEditingController.text = widget.existingTask?.title ?? '';

    _textEditingController.addListener(() {
      // Toggle titleEmpty
      if (_textEditingController.text != '' && titleEmpty) {
        setState(() {
          titleEmpty = false;
        });
      } else if (_textEditingController.text == '' && !titleEmpty) {
        setState(() {
          titleEmpty = true;
        });
      }
    });
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
                  onPressed: () async {
                    bool allowed = await widget.onExit();
                    if (allowed) {
                      Navigator.pop(context);
                    }
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
                // Right button
                widget.existingTask == null
                    ? _buildSaveButton()
                    : buildThreePointsMenu(onDelete: widget.onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Save-button displayed for the creation of new tasks
  Widget _buildSaveButton() {
    return IconButton(
      onPressed: () async {
        int? savedTaskId = await widget.onSaveTask();

        if (savedTaskId != null) {
          // Exit task details screen
          Navigator.pop(context);
        }
      },
      icon: Icon(
        Icons.save_outlined,
        color: titleEmpty ? const Color(0xFF949597) : const Color(0xFF40424A),
      ),
      iconSize: 30,
    );
  }
}
