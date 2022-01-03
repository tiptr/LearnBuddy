import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'learn_list_word.dart';

abstract class LearnList extends Equatable {
  final int id;
  final String name;
  final DateTime creationDate;
  final List<LearnListWord> words;
  final Category? category;
  final bool isArchived;

  // This value is to be computed within the repository.
  // It has the purpose to allow accessing this information directly, without
  // having to prefetch the whole Stream of tasks (via TaskLearnLists)
  // from within the learn-lists,
  // just to have (and display) the amount of tasks referencing the
  // category.
  // Note that in the other direction, tasks directly contain their learnlists.
  //
  // It does not make sense to have to load the whole finished Stream of
  // tasks just to display the learnLists overview.
  //
  // Since Tasks <-> LearnLists is a many-to-many relation, this can easily be
  // computed by counting the references (e.g. in a relationship-table in a
  // relational database)
  // Other than leisure_categories -> leisure_activities, this
  // many-to-many-table will be relatively small, so a trigger would not be
  // worth it, here. TODO
  final int referencingTasksCount;

  const LearnList({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.words,
    this.category,
    required this.isArchived,
    required this.referencingTasksCount,
  });

  /// Get the count of words in this list
  int get wordsCount => words.length;

  @override
  List<Object?> get props =>
      [id, name, creationDate, words, category, referencingTasksCount];
}
