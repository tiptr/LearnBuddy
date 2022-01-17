import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CreateCategoryDto extends Equatable {
  final String name;
  final Color color;

  const CreateCategoryDto({required this.name, required this.color});

  @override
  List<Object> get props => [name, color];
}
