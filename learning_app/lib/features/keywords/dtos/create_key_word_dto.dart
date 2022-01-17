import 'package:equatable/equatable.dart';

class CreateKeyWordDto extends Equatable {
  final String name;

  const CreateKeyWordDto({required this.name});

  @override
  List<Object> get props => [name];
}
