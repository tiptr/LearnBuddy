import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:equatable/equatable.dart';

class LeasureCategoryState extends Equatable {
  late final List<LeisureCategory> leisureCategories;

  LeasureCategoryState() {
    leisureCategories = [
      const LeisureCategory(
        title: "Fun Challenges",
        assetString: "assets/leisure/leisure-group-fun.png",
        starCount: 3,
        countAids: 9,
      ),
      const LeisureCategory(
        title: "Fitness ohne Geräte",
        assetString: "assets/leisure/leisure-group-fitness.png",
        starCount: 7,
        countAids: 17,
      ),
      const LeisureCategory(
        title: "Yoga & Meditation",
        assetString: "assets/leisure/leisure-group-yoga.png",
        starCount: 4,
        countAids: 11,
      ),
      const LeisureCategory(
        title: "Outdoor & Bewegung",
        assetString: "assets/leisure/leisure-group-outdoor.png",
        starCount: 0,
        countAids: 5,
      ),
      const LeisureCategory(
        title: "Weitere Vorschäge",
        assetString: "assets/leisure/leisure-group-further.png",
        starCount: 1,
        countAids: 7,
      ),
    ];
  }

  @override
  List<Object> get props => [leisureCategories];
}
