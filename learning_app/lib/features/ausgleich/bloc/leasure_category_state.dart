import 'package:learning_app/features/ausgleich/model/leasure_category.dart';
import 'package:equatable/equatable.dart';

class LeasureCategoryState extends Equatable {
  late final List<LeasureCategory> leasureCategories;

  LeasureCategoryState() {
    leasureCategories = [
      const LeasureCategory(
          "Fun Challenges", "assets/leasure/leasure-group-fun.png", 3, 9),
      const LeasureCategory("Fitness ohne Geräte",
          "assets/leasure/leasure-group-fitness.png", 7, 17),
      const LeasureCategory(
          "Yoga & Meditation", "assets/leasure/leasure-group-yoga.png", 4, 11),
      const LeasureCategory("Outdoor & Bewegung",
          "assets/leasure/leasure-group-outdoor.png", 0, 5),
      const LeasureCategory("Weitere Vorschäge",
          "assets/leasure/leasure-group-further.png", 1, 7),
    ];
  }

  @override
  List<Object> get props => [leasureCategories];
}
