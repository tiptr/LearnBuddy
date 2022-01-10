import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list_learn_list_word.dart';

class BodyList extends LearnList {
  const BodyList({
    required int id,
    required String name,
    required DateTime creationDate,
    required List<BodyListLearnListWord> words,
    required Category? category,
    required bool isArchived,
  }) : super(
          id: id,
          name: name,
          creationDate: creationDate,
          words: words,
          category: category,
          isArchived: isArchived,
        );

  @override
  List<Object?> get props =>
      [id, name, creationDate, words, category, isArchived];
}
