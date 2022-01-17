import 'package:equatable/equatable.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/old_learning_aid_do_use_learn_list_instead.dart';

abstract class LearnListsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLearningAidState extends LearnListsState {}

class LearningAidLoading extends LearnListsState {}

class LearningAidsLoaded extends LearnListsState {
  final List<OldLearningAidDoUseLearnListInstead> learningAids;

  LearningAidsLoaded({required this.learningAids});

  @override
  List<Object> get props => [learningAids];
}
