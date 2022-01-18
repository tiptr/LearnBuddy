import 'package:equatable/equatable.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learning_aid.dart';

abstract class LearnListsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLearningAidState extends LearnListsState {}

class LearningAidLoading extends LearnListsState {}

class LearningAidsLoaded extends LearnListsState {
  final List<LearningAid> learningAids;

  LearningAidsLoaded({required this.learningAids});

  @override
  List<Object> get props => [learningAids];
}
