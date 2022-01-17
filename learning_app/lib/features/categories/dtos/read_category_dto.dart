import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/features/categories/models/category.dart';

class ReadCategoryDto extends Equatable {
  final int id;
  final String name;
  final Color color;

  const ReadCategoryDto({
    required this.id,
    required this.name,
    required this.color,
  });

  static ReadCategoryDto? fromCategory(Category? category) {
    if (category == null) {
      return null;
    }
    return ReadCategoryDto(
        id: category.id, name: category.name, color: category.color);
  }

  @override
  List<Object> get props => [id, name, color];
}
