import 'package:equatable/equatable.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';

abstract class KeyWordsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialKeyWordsState extends KeyWordsState {}

class KeyWordsLoading extends KeyWordsState {}

class KeyWordsLoaded extends KeyWordsState {
  final Stream<List<ReadKeyWordDto>> keywordsStream;

  KeyWordsLoaded({required this.keywordsStream});

  @override
  List<Object> get props => [keywordsStream];
}
