import 'package:learning_app/features/learning_aids/models/learn_list_word.dart';
import 'body_parts.dart';

class BodyListLearnListWord extends LearnListWord {
  final BodyParts? bodyPart;
  final String? association;

  const BodyListLearnListWord(id, String word,
      {this.bodyPart, this.association})
      : super(
          id: id,
          word: word,
        );

  @override
  List<Object?> get props => [id, word, bodyPart, association];
}
