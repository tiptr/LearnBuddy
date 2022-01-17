import 'package:equatable/equatable.dart';
import 'package:learning_app/database/database.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';

class ReadKeyWordDto extends Equatable {
  final int id;
  final String name;

  const ReadKeyWordDto({
    required this.id,
    required this.name,
  });

  static ReadKeyWordDto fromKeyWord(KeyWord keyWord) {
    return ReadKeyWordDto(
      id: keyWord.id,
      name: keyWord.name,
    );
  }

  static ReadKeyWordDto fromKeywordEntity(KeywordEntity keyWord) {
    return ReadKeyWordDto(
      id: keyWord.id,
      name: keyWord.name,
    );
  }

  @override
  List<Object> get props => [id, name];
}
