import 'package:equatable/equatable.dart';

class ReadLeisureCategoriesDto extends Equatable {
  final int id;
  final String name;
  final String? pathToImage; // nullable (define base image for all without one)

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
    required this.starCount,
    required this.leisureActivityCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        pathToImage,
        starCount,
        leisureActivityCount,
      ];
}
