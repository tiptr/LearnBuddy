import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/services/time_logging/dtos/time_log_dto.dart';
import 'package:learning_app/services/time_logging/models/time_log.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';
import 'package:learning_app/util/injection.dart';

part 'time_logging_events.dart';

part 'time_logging_state.dart';

class TimeLoggingBloc extends Bloc<TimeLoggingEvent, TimeLoggingState> {
  late final TimeLoggingRepository _repository;

  TimeLoggingBloc({TimeLoggingRepository? timeLogRepo}) : super(InactiveState()) {
    _repository = timeLogRepo ?? getIt<TimeLoggingRepository>();

    on<AddTimeLoggingObjectEvent>(_onAdd);
    on<RemoveTimeLoggingObjectEvent>(_onRemove);
    on<StartTimeLoggingEvent>(_onStartTimeLogging);
    on<TimeNoticeEvent>(_onTimerNotice);
  }

  Future<void> _onAdd(AddTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) async {
    int id = event.id;
    List<Task> taskList = await getIt<TaskRepository>().loadTasks();
    Task task = taskList.where((element) => element.id == id).first;
    emit(InitializedState(task: task));
  }

  void _onRemove(
      RemoveTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) {
    emit(InactiveState());
  }

  Future<void> _onStartTimeLogging(
      StartTimeLoggingEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;

    if (currentState is InitializedState) {
      TimeLog timeLog = await _repository.createTimeLog(TimeLogDto(
        taskId: currentState.task.id,
        beginTime: DateTime.now(),
        duration: const Duration(),
      ));

      emit(ActiveState(
        timeLog: timeLog,
        task: currentState.task,
      ));
    }
  }

  Future<void> _onTimerNotice(TimeNoticeEvent event, Emitter<TimeLoggingState> emit) async{
    var currentState = state;
    if (currentState is ActiveState) {
      TimeLog oldTimeLog = currentState.timeLog;
      TimeLog newTimeLog = TimeLog(
          id: oldTimeLog.id,
          taskId: oldTimeLog.taskId,
          beginTime: oldTimeLog.beginTime,
          duration: oldTimeLog.duration + event.duration);

      await _repository.update(newTimeLog.id, TimeLogDto.fromTimeLog(newTimeLog));

      emit(ActiveState(
        timeLog: newTimeLog,
        task: currentState.task,
      ));
    }
  }
}
