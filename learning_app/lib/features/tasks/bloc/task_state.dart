import 'package:learning_app/features/tasks/models/task.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_state.g.dart';


abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialTaskState extends TaskState {}

class TaskLoading extends TaskState {}

// Remember: Whenever you change the structure of json serialized entities, you
// have to run the code generator again. For instructions read the README.md.
@JsonSerializable()
class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];

  /// Connect the generated [_$TasksLoadedFromJson] function to the `fromJson`
  /// factory.
  factory TasksLoaded.fromJson(Map<String, dynamic> json) => _$TasksLoadedFromJson(json);

  /// Connect the generated [_$TasksLoadedToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TasksLoadedToJson(this);
}
