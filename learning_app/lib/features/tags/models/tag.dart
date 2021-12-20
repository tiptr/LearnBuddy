import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String name;
  final int color;

  const Tag({required this.id, required this.name, required this.color});

  @override
  String toString() {
    return "TODO: $id - $name - $color";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color};
  }

  @override
  List<Object> get props => [id, name, color];
}
