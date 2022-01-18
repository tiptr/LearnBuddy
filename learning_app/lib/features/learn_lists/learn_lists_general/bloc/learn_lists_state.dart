import 'package:equatable/equatable.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';

abstract class LearnListsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLearningAidState extends LearnListsState {}

class LearningAidLoading extends LearnListsState {}

class LearningAidsLoaded extends LearnListsState {
  final List<LearnList> learningAids;

  LearningAidsLoaded({required this.learningAids});

  @override
  List<Object> get props => [learningAids];
}
