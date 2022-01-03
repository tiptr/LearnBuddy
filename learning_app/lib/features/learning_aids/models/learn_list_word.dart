import 'package:equatable/equatable.dart';
abstract class LearnListWord extends Equatable {
  final int id;
  final String word;

  const LearnListWord({
    required this.id,
    required this.word,
  });

  @override
  List<Object?> get props => [id, word];
}
