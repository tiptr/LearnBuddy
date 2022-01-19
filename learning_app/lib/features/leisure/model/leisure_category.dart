import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';

class LeisureCategory extends Equatable {
  final int id;
  final String name;
  final String? pathToImage; // nullable (define base image for all without one)
  final List<LeisureActivity> activities;

  const LeisureCategory(
      {required this.id,
      required this.name,
      this.pathToImage,
      required this.activities});

  @override
  List<Object?> get props => [id, name, pathToImage, activities];
}
