import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/learning_aids/models/learn_list.dart';
import 'package:learning_app/features/learning_aids_body_list/models/body_list_learn_list_word.dart';

class BodyList extends LearnList {
  const BodyList(
    int id,
    String name,
    DateTime creationDate,
    List<BodyListLearnListWord> words,
    Category? category,
    bool isArchived,
    int referencingTasksCount,
  ) : super(
          id: id,
          name: name,
          creationDate: creationDate,
          words: words,
          category: category,
          isArchived: isArchived,
          referencingTasksCount: referencingTasksCount,
        );

  @override
  List<Object?> get props =>
      [id, name, creationDate, words, category, isArchived];
}
