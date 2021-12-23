import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final bool done;
  final Category category;

  const Task(
      {required this.id,
      required this.title,
      required this.done,
      required this.category});

  @override
  String toString() {
    return "TODO: $id - $title - $done";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object> get props => [id, title, done];
}
