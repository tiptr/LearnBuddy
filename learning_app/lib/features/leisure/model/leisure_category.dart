import 'package:equatable/equatable.dart';

class LeisureCategory extends Equatable {
  final int id;
  final String name;
  final String? pathToImage; // nullable (define base image for all without one)

  const LeisureCategory({
    required this.id,
    required this.name,
    this.pathToImage,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        pathToImage,
      ];
}
