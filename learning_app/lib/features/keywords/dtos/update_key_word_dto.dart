import 'package:equatable/equatable.dart';

class UpdateKeyWordDto extends Equatable {
  final int id;
  final String name;

  const UpdateKeyWordDto({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
