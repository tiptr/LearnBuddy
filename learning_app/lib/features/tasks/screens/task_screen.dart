import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';

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
              // Spacing at the bottom for FloatingActionButton
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
  Widget _todoCard(Task task, BuildContext context) {
    return TaskCard(task: task);
  }
}
