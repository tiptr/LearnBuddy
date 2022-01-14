import 'package:equatable/equatable.dart';

class ReadLeisureActivitiesDto extends Equatable {
  final int id;
  final int categoryId;
  final String name;
  final Duration duration;
  final String descriptionShort;
  final String? descriptionLong; // nullable
  final int? suitableForAgesAbove; // nullable
  final int? suitableForAgesBelow; // nullable
  final bool isFavorite;
  final String? pathToImage; // nullable (define base image for all without one)

  const ReadLeisureActivitiesDto({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.duration,
    required this.descriptionShort,
    this.descriptionLong,
    this.suitableForAgesAbove,
    this.suitableForAgesBelow,
    required this.isFavorite,
    this.pathToImage,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        name,
        duration,
        descriptionShort,
        descriptionLong,
        suitableForAgesAbove,
        suitableForAgesBelow,
        isFavorite,
        pathToImage,
      ];
}
