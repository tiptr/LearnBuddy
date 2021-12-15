import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';

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
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<TaskCubit>(context)
                        .createTask(
                          CreateTaskDto(
                            title: textController.text,
                            done: false,
                          ),
                        )
                        .whenComplete(() => Navigator.pop(context));
                  },
                  icon: const Icon(Icons.save),
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
  Size get preferredSize => const Size.fromHeight(80);
}