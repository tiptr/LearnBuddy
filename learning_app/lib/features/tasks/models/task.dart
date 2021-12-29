import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

// Remember: Whenever you change the structure of json serialized entities, you
// have to run the code generator again. For instructions read the README.md.
@JsonSerializable()
class Task extends Equatable {
  final int id;
  final String title;
  final bool done;

  const Task({required this.id, required this.title, required this.done});

  @override
  String toString() {
    return "TODO: $id - $title - $done";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'done': done ? 1 : 0};
  }

  @override
  List<Object> get props => [id, title, done];

  /// Connect the generated [_$TaskFromJson] function to the `fromJson`
  /// factory.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Connect the generated [_$TaskToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
