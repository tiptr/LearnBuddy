import 'package:equatable/equatable.dart';

class KeyWord extends Equatable {
  final int id;
  final String name;

  const KeyWord({required this.id, required this.name,});

  @override
  List<Object> get props => [id, name];
}
