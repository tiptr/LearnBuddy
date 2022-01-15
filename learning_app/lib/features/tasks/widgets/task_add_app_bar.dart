import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/tasks/bloc/add_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/add_task_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:drift/drift.dart' as drift;

class TaskAddAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController textController;

  const TaskAddAppBar({Key? key, required this.textController})
      : super(key: key);

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
                    controller: textController,
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

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
