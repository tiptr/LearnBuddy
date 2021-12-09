import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TaskCubit>(context).loadTasks();

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<TaskCubit, List<Task>>(
          builder: (context, todos) => Column(
            children: [
              ...todos.map((t) => _todoCard(t, context)).toList(),
              const SizedBox(height: 100.0)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Generates a card that represents a todo element
  Widget _todoCard(Task todo, BuildContext context) {
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
      child: _todoListItem(todo, context),
    );
  }

  Widget _todoListItem(Task todo, BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()),
      onDismissed: (_) =>
          BlocProvider.of<TaskCubit>(context).deleteTask(todo.id!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          _doneMark(
            todo,
            () => {BlocProvider.of<TaskCubit>(context).updateTask(todo)},
          ),
        ],
      ),
    );
  }

  // Generates a green circle when done or a red circle when still todo
  Widget _doneMark(Task todo, Function onToggle) {
    return GestureDetector(
      onTap: () => onToggle(),
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
