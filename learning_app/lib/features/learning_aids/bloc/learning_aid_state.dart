import 'package:learning_app/features/learning_aids/models/learning_aid.dart';
import 'package:equatable/equatable.dart';

abstract class LearningAidState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLearningAidState extends LearningAidState {}

class LearningAidLoading extends LearningAidState {}

class LearningAidsLoaded extends LearningAidState {
  final List<LearningAid> learningAids;

  LearningAidsLoaded({required this.learningAids});

  @override
  List<Object> get props => [learningAids];
}
