import 'package:equatable/equatable.dart';

// TODO: Please use the 'LearnList' model instead of this
// It was created earlier and implements the features of a LearnList as
// we modelled it together in our artefact
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
