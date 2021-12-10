import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final bool done;

  const Task({required this.id, required this.title, required this.done});

  @override
  String toString() {
    return "TODO: $id - $title - $done";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object?> get props => [id, title, done];
}
