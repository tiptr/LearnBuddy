import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';

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

  static ReadLeisureActivitiesDto fromLeisureActivity(LeisureActivity leisureActivity) {
    return ReadLeisureActivitiesDto(
        id: leisureActivity.id,
        categoryId: leisureActivity.categoryId,
        name: leisureActivity.name,
        duration: leisureActivity.duration,
        descriptionShort: leisureActivity.descriptionShort,
        descriptionLong: leisureActivity.descriptionLong,
        suitableForAgesAbove: leisureActivity.suitableForAgesAbove,
        suitableForAgesBelow: leisureActivity.suitableForAgesBelow,
        isFavorite: leisureActivity.isFavorite,
        pathToImage: leisureActivity.pathToImage,
    );
}

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
