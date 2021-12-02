import 'package:flutter/material.dart';
import 'package:learning_app/todo/models/todo.dart';
import 'package:learning_app/todo/screens/add_todo_screen.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: todos.map((t) => _todoCard(t)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTodoScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Generates a card that represents a todo element
  Widget _todoCard(Todo todo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          _doneMark(todo),
        ],
      ),
    );
  }

  // Generates a green circle when done or a red circle when still todo
  Widget _doneMark(Todo todo) {
    return GestureDetector(
      onTap: () => print("Toggling done for $todo"),
      child: Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: todo.done ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
