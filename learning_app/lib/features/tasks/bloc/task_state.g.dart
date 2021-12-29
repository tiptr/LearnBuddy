// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksLoaded _$TasksLoadedFromJson(Map<String, dynamic> json) => TasksLoaded(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksLoadedToJson(TasksLoaded instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
    };
