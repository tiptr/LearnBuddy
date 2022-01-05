import 'package:equatable/equatable.dart';

class UpdateLearningAidDto extends Equatable {
  final String title;
  final bool done;

  const UpdateLearningAidDto({required this.title, required this.done});

  Map<String, dynamic> toMap() {
    return {'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object?> get props => [title, done];
}
