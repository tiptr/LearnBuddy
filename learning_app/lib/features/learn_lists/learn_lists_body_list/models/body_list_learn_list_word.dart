import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'body_parts.dart';

class BodyListLearnListWord extends LearnListWord {
  final BodyParts? bodyPart;
  final String? association;

  const BodyListLearnListWord({required id, required String word,
      this.bodyPart, this.association})
      : super(
          id: id,
          word: word,
        );

  @override
  List<Object?> get props => [id, word, bodyPart, association];
}
