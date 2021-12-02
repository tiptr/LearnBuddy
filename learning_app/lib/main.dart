import 'package:flutter/material.dart';
import 'package:learning_app/todo/models/todo.dart';
import 'package:learning_app/todo/screens/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Lernbuddy'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodosScreen(
              todos: [
                // TODO: These items should be loaded from the DB and then
                //       be managed in a state management solution like Bloc.
                Todo(title: "Todo 1", done: true),
                Todo(title: "Todo 2", done: false),
                Todo(title: "Todo 3", done: true),
                Todo(title: "Todo 4", done: false),
              ],
            ),
          ),
        ),
        child: const Icon(Icons.list),
      ),
    );
  }
}
