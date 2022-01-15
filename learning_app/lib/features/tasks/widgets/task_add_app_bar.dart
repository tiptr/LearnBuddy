import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/add_task_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:drift/drift.dart' as drift;
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';

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
                      BlocProvider.of<AddTaskCubit>(context)
                          .addTaskAttribute(CreateTaskDto(
                        title: drift.Value(text),
                      ));
                    },
                    autofocus: true,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<AddTaskCubit>(context)
                        .saveTask()
                        .whenComplete(() {
                      if (BlocProvider.of<AddTaskCubit>(context).state
                          is TaskAdded) {
                        Navigator.pop(context);
                      }
                    });
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
