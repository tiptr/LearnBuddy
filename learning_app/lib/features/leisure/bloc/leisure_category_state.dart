import 'package:learning_app/features/leisure/model/leisure_category.dart';
import 'package:equatable/equatable.dart';

class LeasureCategoryState extends Equatable {
  late final List<LeisureCategory> leisureCategories;

  LeasureCategoryState() {
    leisureCategories = [
      const LeisureCategory(
        id: 0,
        name: "Fun Challenges",
        pathToImage: "assets/leisure/leisure-group-fun.png",
        starCount: 3,
        leisureActivityCount: 9,
      ),
      const LeisureCategory(
        id: 1,
        name: "Fitness ohne Geräte",
        pathToImage: "assets/leisure/leisure-group-fitness.png",
        starCount: 7,
        leisureActivityCount: 17,
      ),
      const LeisureCategory(
        id: 2,
        name: "Yoga & Meditation",
        pathToImage: "assets/leisure/leisure-group-yoga.png",
        starCount: 4,
        leisureActivityCount: 11,
      ),
      const LeisureCategory(
        id: 3,
        name: "Outdoor & Bewegung",
        pathToImage: "assets/leisure/leisure-group-outdoor.png",
        starCount: 0,
        leisureActivityCount: 5,
      ),
      const LeisureCategory(
        id: 4,
        name: "Weitere Vorschäge",
        pathToImage: "assets/leisure/leisure-group-further.png",
        starCount: 1,
        leisureActivityCount: 7,
      ),
    ];
  }

  @override
  List<Object> get props => [leisureCategories];
}
