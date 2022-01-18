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
  final List<LeisureActivity> selectedLeisureActivities;
  late List<ReadLeisureActivitiesDto> listViewLeisureActivities;

  LeisureActivityListLoadedState({required this.selectedLeisureActivities}) {
    listViewLeisureActivities = [];
    for (LeisureActivity activity in selectedLeisureActivities) {
      listViewLeisureActivities
          .add(ReadLeisureActivitiesDto.fromLeisureActivity(activity));
    }
  }

  @override
  List<Object> get props => [listViewLeisureActivities];
}
