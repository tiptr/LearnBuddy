import 'package:learning_app/features/ausgleich/model/leasure_category.dart';
import 'package:equatable/equatable.dart';

class LeasureCategoryState extends Equatable {
  late final List<LeasureCategory> leasureCategories;

  LeasureCategoryState() {
    leasureCategories = [
      const LeasureCategory(
        title: "Fun Challenges",
        assetString: "assets/leasure/leasure-group-fun.png",
        starCount: 3,
        countAids: 9,
      ),
      const LeasureCategory(
        title: "Fitness ohne Geräte",
        assetString: "assets/leasure/leasure-group-fitness.png",
        starCount: 7,
        countAids: 17,
      ),
      const LeasureCategory(
        title: "Yoga & Meditation",
        assetString: "assets/leasure/leasure-group-yoga.png",
        starCount: 4,
        countAids: 11,
      ),
      const LeasureCategory(
        title: "Outdoor & Bewegung",
        assetString: "assets/leasure/leasure-group-outdoor.png",
        starCount: 0,
        countAids: 5,
      ),
      const LeasureCategory(
        title: "Weitere Vorschäge",
        assetString: "assets/leasure/leasure-group-further.png",
        starCount: 1,
        countAids: 7,
      ),
    ];
  }

  @override
  List<Object> get props => [leasureCategories];
}
