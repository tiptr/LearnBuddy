import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/bloc/leisure_state.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/util/injection.dart';

class LeisureCubit extends Cubit<LeisureState> {
  late final LeisureRepository _leisureRepository;

  LeisureCubit({LeisureRepository? leisureRepository})
      : super(InitialLeisureCategoryState()) {
    _leisureRepository = leisureRepository ?? getIt<LeisureRepository>();
  }

  Future<void> loadLeisureCategories() async {
    // TODO: I guess the state will be the right place to store the currently selected filters and more
    var leisureCategories = _leisureRepository.watchLeisureCategories();
    emit(LeisureCategoryLoaded(
        selectedLeisureCategoriesStream: leisureCategories));
  }

  Future<void> toggleFavorite(int activityId, bool isFavorite) async {
    await _leisureRepository.toggleFavorite(activityId, isFavorite);
  }
}
