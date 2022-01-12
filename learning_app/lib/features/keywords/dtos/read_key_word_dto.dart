import 'package:equatable/equatable.dart';

class ReadKeyWordDto extends Equatable {
  final int id;
  final String name;

  const ReadKeyWordDto({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
