import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';



part 'time_logging_events.dart';

part 'time_logging_state.dart';


class TimeLoggingBloc extends Bloc<TimeLoggingEvent, TimeLoggingState>{
  TimeLoggingRepository repository;

  TimeLoggingBloc(this.repository) : super(TimeLoggingNoObjectState()) {
    on<AddTimeLoggingObjectEvent>(_onAdd);
    on<RemoveTimeLoggingObjectEvent>(_onRemove);
    on<AddDurationEvent>(_addDuration);
  }

  @override	
  Future<void> close() {
    repository.disposeRepository();
    return super.close();
  }


  Future<void> init() async {
    await repository.initRepository();
  }
  


  void _onAdd(AddTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) {
    int id  = event.id;
    emit(TimeLoggingHasObjectState(id));
  }

  void _onRemove(RemoveTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) {
    emit(TimeLoggingNoObjectState());
  }

  

  void _addDuration (event, Emitter<TimeLoggingState> emit)  {
    var currentState = state;
    if (currentState is TimeLoggingHasObjectState){
      Duration currentDuration = repository.read(currentState.id);
      repository.update(currentState.id, currentDuration + event.duration);
    }
  }
}




