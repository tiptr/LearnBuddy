import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';

class ReadLeisureCategoriesDto extends Equatable {
  final int id;
  final String name;
  final String? pathToImage; // nullable (define base image for all without one)
  final List<LeisureActivity>? activities;

  // This two values are redundancy by design!
  // They have the purpose to allow accessing this information directly, without
  // having to prefetch the whole Stream of activities from within a category,
  // just to have (and display) the amount of (starred) activities matching the
  // category.
  // This is important here, because the huge amount of tuples is the
  // activities, not the categories.
  // It does not make sense to have to load the whole finished Stream of
  // activities just to display the category overview.
  final int starCount;
  final int leisureActivityCount;

  const ReadLeisureCategoriesDto({
    required this.id,
    required this.name,
    this.pathToImage,
    this.activities,
    required this.starCount,
    required this.leisureActivityCount,
  });

  static ReadLeisureCategoriesDto fromLeisureCategory(LeisureCategory leisureCategory) {
    return ReadLeisureCategoriesDto(
      id: leisureCategory.id,
      name: leisureCategory.name,
      pathToImage: leisureCategory.pathToImage,
      activities: leisureCategory.activities,
      starCount: leisureCategory.activities.where((activity) => activity.isFavorite).toList().length,
      leisureActivityCount: leisureCategory.activities.length
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        pathToImage,
        activities,
        starCount,
        leisureActivityCount,
      ];
}
