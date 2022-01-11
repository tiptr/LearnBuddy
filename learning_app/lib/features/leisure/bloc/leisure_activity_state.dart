import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';

class LeasureActivityState extends Equatable {
  late final List<ReadLeisureActivitiesDto> leisureActivitiesDtos;

  LeasureActivityState() {
    leisureActivitiesDtos = [
      const ReadLeisureActivitiesDto(
        id: 0,
        name: "Dips am Stuhl",
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
