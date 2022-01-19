part of 'suggested_leisure_cubit.dart';

@immutable
abstract class SuggestedLeisureState {}

class SuggestedLeisureInitial extends SuggestedLeisureState {}

class SuggestedLeisureLoaded extends SuggestedLeisureState {
  final LeisureActivity activeLeisureActivity;

  SuggestedLeisureLoaded(this.activeLeisureActivity);
}
