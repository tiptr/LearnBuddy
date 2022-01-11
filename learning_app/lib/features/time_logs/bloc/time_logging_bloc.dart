import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/features/time_logs/dtos/time_log_dto.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';
import 'package:learning_app/features/time_logs/repository/time_logging_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/logger.dart';

part 'time_logging_events.dart';

part 'time_logging_state.dart';

class TimeLoggingBloc extends Bloc<TimeLoggingEvent, TimeLoggingState> {
  late final TimeLoggingRepository _timeLoggingRepository;
  late final TaskRepository _taskRepository;
  StreamSubscription<TaskWithQueueStatus?>? _streamSubscriptionTask;

  TimeLoggingBloc(
      {TimeLoggingRepository? timeLogRepo, TaskRepository? taskRepository})
      : super(InactiveState()) {
    _timeLoggingRepository = timeLogRepo ?? getIt<TimeLoggingRepository>();
    _taskRepository = taskRepository ?? getIt<TaskRepository>();

    on<AddTimeLoggingObjectEvent>(_onAdd);
    on<RemoveTimeLoggingObjectEvent>(_onRemove);
    on<StartTimeLoggingEvent>(_onStartTimeLogging);
    on<TimeNoticeEvent>(_onTimerNotice);
    on<TaskChangedEvent>(_onTaskChanged);
  }

  Future<void> _onAdd(
      AddTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) async {
    Stream<TaskWithQueueStatus?> stream =
        _taskRepository.watchQueuedTaskWithId(id: event.parentId);
    TaskWithQueueStatus? parentTask = await stream.first;
    if (parentTask == null) {
      throw ArgumentError('Repo did not return any Task for id ${event.id}');
    }
    Task task = parentTask.task.allTasks
        .firstWhere((element) => element.id == event.id);
    emit(InitializedState(
      parentTask: parentTask,
      task: task,
    ));
    _streamSubscriptionTask = stream.listen((TaskWithQueueStatus? parentTask) {
      if (parentTask == null) {
        throw ArgumentError('Repo did not return any Task for id ${event.id}');
      }
      Task task = parentTask.task.allTasks
          .firstWhere((element) => element.id == event.id);
      add(TaskChangedEvent(
        parentTask: parentTask,
        task: task,
      ));
    });
  }

  void _onRemove(
      RemoveTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) {
    _streamSubscriptionTask?.cancel();
    emit(InactiveState());
  }

  Future<void> _onStartTimeLogging(
      StartTimeLoggingEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;
    if (currentState is InitializedState) {
      Task task = currentState.task;
      TimeLog timeLog = await _timeLoggingRepository.createTimeLog(TimeLogDto(
        taskId: task.id,
        beginTime: event.beginTime,
        duration: const Duration(),
      ));

      emit(ActiveState(
        timeLog: timeLog,
        parentTask: currentState.parentTask,
        task: currentState.task,
      ));
    }
  }

  Future<void> _onTimerNotice(
      TimeNoticeEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;
    //Activates the state if Task is added while Timer is running
    add(StartTimeLoggingEvent(beginTime: DateTime.now()));

    if (currentState is ActiveState) {
      TimeLog oldTimeLog = currentState.timeLog;
      TimeLog newTimeLog = TimeLog(
          id: oldTimeLog.id,
          taskId: oldTimeLog.taskId,
          beginTime: oldTimeLog.beginTime,
          duration: oldTimeLog.duration + event.duration);

      await _timeLoggingRepository.update(
          newTimeLog.id, TimeLogDto.fromTimeLog(newTimeLog));

      emit(ActiveState(
        timeLog: newTimeLog,
        parentTask: currentState.parentTask,
        task: currentState.task,
      ));
    }
  }

  Future<void> _onTaskChanged(
      TaskChangedEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;
    if (currentState is ActiveState) {
      emit(ActiveState(
        timeLog: currentState.timeLog,
        parentTask: event.parentTask,
        task: event.task,
      ));
    }
    else if (currentState is InitializedState) {
      emit(InitializedState(
        parentTask: event.parentTask,
        task: event.task,
      ));
    } else {
      logger.d("Invalid state.");
    }
  }
}
