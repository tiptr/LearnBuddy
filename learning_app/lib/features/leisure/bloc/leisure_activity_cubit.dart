import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_state.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/util/injection.dart';

class LeisureActivityCubit extends Cubit<LeisureActivityState> {
  late final List<LeisureActivity>? _leisureActivityList;
  late final LeisureRepository _leisureRepository;

  LeisureActivityCubit({LeisureRepository? leisureRepository})
      : super(InitialLeisureActivityState()) {
    _leisureRepository = leisureRepository ?? getIt<LeisureRepository>();
  }

  void setActivityList(List<LeisureActivity>? leisureActivityList) {
    _leisureActivityList = leisureActivityList;
    emit(LeisureActivityListLoadedState(
        selectedLeisureActivities: _leisureActivityList!));
  }

  Future<void> toggleFavorite(int activityId, bool isFavorite) async {
    await _leisureRepository.toggleFavorite(activityId, isFavorite);
  }
}
