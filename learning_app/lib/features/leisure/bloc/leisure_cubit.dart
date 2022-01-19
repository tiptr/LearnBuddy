import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/bloc/leisure_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/util/injection.dart';

class LeisureCubit extends Cubit<LeisureState> {
  late final LeisureRepository _leisureRepository;

  LeisureCubit({LeisureRepository? leisureRepository})
      : super(InitialLeisuresState()) {
    _leisureRepository = leisureRepository ?? getIt<LeisureRepository>();
  }

  Future<void> loadLeisureCategories() async {
    // TODO: I guess the state will be the right place to store the currently selected filters and more
    var leisureCategories = _leisureRepository.watchLeisureCategories();
    emit(
      LeisuresLoaded(selectedLeisureCategoriesStream: leisureCategories),
    );
  }

  Future<void> toggleFavorite(int activityId, bool isFavorite) async {
    await _leisureRepository.toggleFavorite(activityId, isFavorite);
  }

  Stream<List<ReadLeisureActivitiesDto>> watchLeisureActivitiesByCategoryId({
    required int categoryId,
  }) {
    final currentState = state;
    if (currentState is LeisuresLoaded) {
      return currentState.listViewLeisureCategoriesStream.map((categories) =>
          categories
              .firstWhere((category) => category.id == categoryId)
              .activities);
    } else {
      throw InvalidStateException();
    }
  }

  Stream<ReadLeisureActivitiesDto> watchLeisureActivityById({
    required int categoryId,
    required int activityId,
  }) {
    final currentState = state;
    if (currentState is LeisuresLoaded) {
      final activitiesStream =
          watchLeisureActivitiesByCategoryId(categoryId: categoryId);

      return activitiesStream.map((activities) =>
          activities.firstWhere((activity) => activity.id == activityId));
    } else {
      throw InvalidStateException();
    }
  }

  Future<ReadLeisureActivitiesDto?> getRandomLeisureActivity() async {
    if (state is! LeisuresLoaded) {
      return null;
    }

    var leisureCategories =
        await _leisureRepository.watchLeisureCategories().first;

    var allActivities = leisureCategories
        .map((e) => e.activities)
        .reduce((value, element) => [...value, ...element]);

    var todayNumber = DateTime.now().day;

    // Calculate a pseudo random activity index,
    // but always the same for the same day.
    var pseudoRandomActivity =
        allActivities[allActivities.length - 1 % todayNumber];

    return ReadLeisureActivitiesDto.fromLeisureActivity(
      pseudoRandomActivity,
    );
  }
}
