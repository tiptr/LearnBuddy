import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_state.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';

class LeasureActivityState extends Equatable {
  late final List<ReadLeisureActivitiesDto> leisureActivitiesDtos;

  LeasureActivityState() {
    leisureActivitiesDtos = [
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Dips am Stuhl",
        category: LeisureCategory(id: 1, name: "Fitness ohne Geräte"), //TODO: Link the right category
        duration: Duration(minutes: 5),
        descriptionShort: "Jeweils 10 Dips, dann eine kurze Pause.",
        descriptionLong: "Die arme gerade halten.",
        suitableForAgesAbove: 13,
        suitableForAgesBelow: 50,
        isFavorite: false,
        pathToImage: "assets/leisure/leisure-group-fitness.png",
      ),
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Liegestütze",
        category: LeisureCategory(id: 1, name: "Fitness ohne Geräte"), //TODO: Link the right category
        duration: Duration(minutes: 5),
        descriptionShort: "Jeweils 10 Dips, dann eine kurze Pause.",
        descriptionLong: "Die arme gerade halten.",
        suitableForAgesAbove: 13,
        suitableForAgesBelow: 50,
        isFavorite: false,
        pathToImage: "assets/leisure/leisure-group-fitness.png",
      ),
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Kniebeugen",
        category: LeisureCategory(id: 1, name: "Fitness ohne Geräte"), //TODO: Link the right category
        duration: Duration(minutes: 5),
        descriptionShort: "Jeweils 10 Dips, dann eine kurze Pause.",
        descriptionLong: "Die arme gerade halten.",
        suitableForAgesAbove: 13,
        suitableForAgesBelow: 50,
        isFavorite: false,
        pathToImage: "assets/leisure/leisure-group-fitness.png",
      ),
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Im Stand joggen",
        category: LeisureCategory(id: 1, name: "Fitness ohne Geräte"), //TODO: Link the right category
        duration: Duration(minutes: 5),
        descriptionShort: "Jeweils 10 Dips, dann eine kurze Pause.",
        descriptionLong: "Die arme gerade halten.",
        suitableForAgesAbove: 13,
        suitableForAgesBelow: 50,
        isFavorite: false,
        pathToImage: "assets/leisure/leisure-group-fitness.png",
      ),
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Ganzkörpertraining",
        category: LeisureCategory(id: 1, name: "Fitness ohne Geräte"), //TODO: Link the right category
        duration: Duration(minutes: 15),
        descriptionShort: "Jeweils 10 Dips, dann eine kurze Pause.",
        descriptionLong: "Die arme gerade halten.",
        suitableForAgesAbove: 13,
        suitableForAgesBelow: 50,
        isFavorite: false,
        pathToImage: "assets/leisure/leisure-group-fitness.png",
      ),
    ];
  }

  @override
  List<Object> get props => [leisureActivitiesDtos];
}
