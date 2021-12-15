import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';

class TaskAddScreen extends StatelessWidget {
  TaskAddScreen({Key? key}) : super(key: key);

  // Controller that handles text input events and state
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () => {
                BlocProvider.of<TaskCubit>(context)
                    .createTask(
                      CreateTaskDto(title: _controller.text, done: false),
                    )
                    .whenComplete(() => Navigator.pop(context))
              },
              child: _submitButtonWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButtonWidget(BuildContext context) {
    return Ink(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: const Center(
        child: Text(
          "Speichern",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
