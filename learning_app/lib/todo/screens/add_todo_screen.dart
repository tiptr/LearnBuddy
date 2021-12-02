import 'package:flutter/material.dart';
import 'package:learning_app/todo/models/todo.dart';

class AddTodoScreen extends StatelessWidget {
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
                print(Todo(title: _controller.text, done: false).toString()),
                Navigator.pop(context)
              },
              child: Ink(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
