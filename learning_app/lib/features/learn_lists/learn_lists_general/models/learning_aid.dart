import 'package:equatable/equatable.dart';

class LearningAid extends Equatable {
  final int id;
  final String title;

  const LearningAid({
    required this.id,
    required this.title,
  });

  @override
  String toString() {
    return "TODO: $id - $title";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  @override
  List<Object> get props => [id, title];
}
