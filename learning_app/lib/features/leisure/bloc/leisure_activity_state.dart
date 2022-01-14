import 'package:equatable/equatable.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';

abstract class LeisureActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLeisureActivityState extends LeisureActivityState {}

// ignore: must_be_immutable
class LeisureActivityListLoadedState extends LeisureActivityState {
  final Stream<List<LeisureActivity>> selectedLeisureActivitiesStream;
  late Stream<List<ReadLeisureActivitiesDto>> listViewLeisureActivitiesStream;

  LeisureActivityListLoadedState({required this.selectedLeisureActivitiesStream}) {
    listViewLeisureActivitiesStream = selectedLeisureActivitiesStream.map((activityList) {
      return activityList
          .map((activity) => ReadLeisureActivitiesDto(
            id: activity.id, 
            categoryId: activity.categoryId,
            name: activity.name,
            duration: activity.duration,
            descriptionShort: activity.descriptionShort,
            descriptionLong: activity.descriptionLong,
            suitableForAgesAbove: activity.suitableForAgesAbove,
            suitableForAgesBelow: activity.suitableForAgesBelow,
            isFavorite: activity.isFavorite,
            pathToImage: activity.pathToImage))
          .toList();
    });
  }
  
  @override
  List<Object> get props => [];
}