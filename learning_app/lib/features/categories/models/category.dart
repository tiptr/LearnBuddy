import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final int color;

  const Category({required this.id, required this.name, required this.color});

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
