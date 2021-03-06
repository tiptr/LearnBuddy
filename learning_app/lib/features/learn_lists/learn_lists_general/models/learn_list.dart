import 'package:equatable/equatable.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'learn_list_word.dart';

class LearnList extends Equatable {
  final int id;
  final String name;
  final DateTime creationDate;
  final List<LearnListWord> words;
  final Category? category;
  final bool isArchived;

  const LearnList({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.words,
    this.category,
    required this.isArchived,
  });

  /// Get the count of words in this list
  int get wordsCount => words.length;

  @override
  List<Object?> get props => [id, name, creationDate, words, category];
}
