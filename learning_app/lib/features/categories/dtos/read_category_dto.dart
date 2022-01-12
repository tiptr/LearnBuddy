import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ReadCategoryDto extends Equatable {
  final int id;
  final String name;
  final Color color;

  const ReadCategoryDto({
    required this.id,
    required this.name,
    required this.color,
  });

  @override
  List<Object> get props => [id, name, color];
}
