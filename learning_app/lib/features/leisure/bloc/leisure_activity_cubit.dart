import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_state.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/util/injection.dart';

class LeasureActivityCubit extends Cubit<LeisureActivityState> {
  late final Stream<List<LeisureActivity>>? _leisureActivityList;
  late final LeisureRepository _leisureRepository;
  
  LeasureActivityCubit({LeisureRepository? leisureRepository, Stream<List<LeisureActivity>>? leisureActivityList}) : super(InitialLeisureActivityState()) {
    _leisureActivityList = leisureActivityList;
    _leisureRepository = leisureRepository ?? getIt<LeisureRepository>();
    emit(LeisureActivityListLoadedState(selectedLeisureActivitiesStream: _leisureActivityList!));
  }

  Future<void> toggleFavorite(int activityId, bool isFavorite) async {
    await _leisureRepository.toggleFavorite(activityId, isFavorite);
  }
}
