import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:drift/drift.dart' as drift;
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/util/logger.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class TaskAddAppBar extends StatefulWidget implements PreferredSizeWidget {
  final DetailsReadTaskDto? existingTask;
  final Function() onSaveTask;

  const TaskAddAppBar({
    Key? key,
    this.existingTask,
    required this.onSaveTask,
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onBackgroundHard,
                  ),
                  iconSize: 30,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Name der Aufgabe',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .textStyle2
                          .withOnBackgroundSoft
                          .withOutBold,
                      border: InputBorder.none,
                    ),
                    controller: _textEditingController,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle2
                        .withOnBackgroundHard
                        .withBold,
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
                    int? savedTaskId = await widget.onSaveTask();

                    if (savedTaskId != null) {
                      // Exit task details screen
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    color: Theme.of(context).colorScheme.onBackgroundHard,
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
