import 'package:equatable/equatable.dart';

class CreateTaskDto extends Equatable {
  final String title;
  final bool done;

  const CreateTaskDto({required this.title, required this.done});

  Map<String, dynamic> toMap() {
    return {'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object?> get props => [title, done];
}
