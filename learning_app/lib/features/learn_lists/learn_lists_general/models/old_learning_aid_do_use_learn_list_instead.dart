import 'package:equatable/equatable.dart';

class OldLearningAidDoUseLearnListInstead extends Equatable {
  final int id;
  final String title;

  const OldLearningAidDoUseLearnListInstead({
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