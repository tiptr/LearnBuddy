import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'package:learning_app/features/leisure/repositories/leisure_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:meta/meta.dart';

part 'suggested_leisure_state.dart';

class SuggestedLeisureCubit extends Cubit<SuggestedLeisureState> {
  final LeisureRepository _repository = getIt<LeisureRepository>();
  StreamSubscription? _subscription;

  SuggestedLeisureCubit() : super(SuggestedLeisureInitial());

  void init() {
    _subscription = _repository.watchRandomLeisureActivity().listen((event) {
      emit(SuggestedLeisureLoaded(event));
    });
  }

  void newLeisureActivity() async {
    _subscription?.cancel();
    Stream<LeisureActivity> stream = _repository.watchRandomLeisureActivity();
    _subscription = stream.listen((event) {
      emit(SuggestedLeisureLoaded(event));
    });

    emit(SuggestedLeisureLoaded(await stream.first));
  }
}
