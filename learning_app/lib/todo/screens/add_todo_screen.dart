import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/todo/bloc/todos_cubit.dart';

class AddTodoScreen extends StatelessWidget {
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
                BlocProvider.of<TodosCubit>(context)
                    .createTodo(_controller.text)
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
