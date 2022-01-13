import 'package:equatable/equatable.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';

abstract class KeyWordsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialKeyWordsState extends KeyWordsState {}

class KeyWordsLoading extends KeyWordsState {}

class KeyWordsLoaded extends KeyWordsState {
  final Stream<List<KeyWord>> keywordsStream;

  KeyWordsLoaded({required this.keywordsStream});

  @override
  List<Object> get props => [keywordsStream];
}
