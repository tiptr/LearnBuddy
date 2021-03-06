import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/features/time_logs/dtos/time_log_dto.dart';
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
    on<StopTimeLoggingEvent>(_onStopTimeLogging);
  }

  Future<void> _onAdd(
      AddTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) async {
    if (state is ActiveState) {
      add(const RemoveTimeLoggingObjectEvent());
      add(AddTimeLoggingObjectEvent(event.id, event.parentId));
      //add(StartTimeLoggingEvent(beginTime: DateTime.now()));
      return;
    }
    if (state is InitializedState) {
      add(const RemoveTimeLoggingObjectEvent());
      add(AddTimeLoggingObjectEvent(event.id, event.parentId));
      return;
    }
    assert(state is InactiveState);
    Stream<TaskWithQueueStatus?> stream =
        _taskRepository.watchQueuedTaskWithId(id: event.parentId);

    TaskWithQueueStatus? parentTask = await stream.first;
    // This is duplicated code, but I don't know how to fix it.
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
      // Duplicate
      Task? task;
      if (parentTask == null) {
        logger.d(
            'Repo did not return any Task for id ${event.id}\nReturning to Inactive State.');
      } else {
        task = parentTask.task.allTasks
            .firstWhere((element) => element.id == event.id);
      }
      // If no task is found, null is emitted for both tasks
      add(TaskChangedEvent(
        parentTask: parentTask,
        task: task,
      ));
    });
  }

  void _onRemove(
      RemoveTimeLoggingObjectEvent event, Emitter<TimeLoggingState> emit) {
    var currentState = state;
    if (currentState is ActiveState) {
      _writeTimeLog(currentState);
    }
    _streamSubscriptionTask?.cancel();
    emit(InactiveState());
  }

  Future<void> _onStartTimeLogging(
      StartTimeLoggingEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;
    if (currentState is InitializedState) {
      Task task = currentState.task;
      TimeLogDto timeLog = TimeLogDto(
        taskId: task.id,
        beginTime: event.beginTime,
        duration: const Duration(),
      );

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

    if (currentState is ActiveState) {
      TimeLogDto oldTimeLog = currentState.timeLog;
      TimeLogDto newTimeLog = TimeLogDto(
          taskId: oldTimeLog.taskId,
          beginTime: oldTimeLog.beginTime,
          duration: oldTimeLog.duration + event.duration);

      emit(ActiveState(
        timeLog: newTimeLog,
        parentTask: currentState.parentTask,
        task: currentState.task,
      ));
    }
    // Notify that a loaded task that it has to activate time logging
    if (currentState is InitializedState) {
      add(StartTimeLoggingEvent(beginTime: DateTime.now()));
    }
  }

  // This is not an exposed Event. This is just to updated the Task in the UI
  // if the watched Stream changes.
  Future<void> _onTaskChanged(
      TaskChangedEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;

    if (event.task == null || event.parentTask == null) {
      emit(InactiveState());
    } else {
      if (currentState is ActiveState) {
        emit(ActiveState(
          // Use the currently active timeLog, because it's the same Object
          // only some properties e.g. the title have changed.
          timeLog: currentState.timeLog,
          parentTask: event.parentTask!,
          task: event.task!,
        ));
      } else if (currentState is InitializedState) {
        emit(InitializedState(
          parentTask: event.parentTask!,
          task: event.task!,
        ));
      } else {
        logger.d("Invalid state.");
      }
    }
  }

  Future<void> _writeTimeLog(ActiveState currentState) async {
    TimeLogDto timeLog = currentState.timeLog;
    TimeLogDto finalTimeLog = TimeLogDto(
      beginTime: timeLog.beginTime,
      taskId: timeLog.taskId,
      duration: DateTime.now().difference(timeLog.beginTime),
    );

    await _timeLoggingRepository.createTimeLog(finalTimeLog);
  }

  FutureOr<void> _onStopTimeLogging(
      StopTimeLoggingEvent event, Emitter<TimeLoggingState> emit) async {
    var currentState = state;
    if (currentState is! ActiveState) {
      logger.d('Stop TimeLogging on not active State');
      return;
    }

    TimeLogDto timeLog = currentState.timeLog;
    TimeLogDto finalTimeLog = TimeLogDto(
      beginTime: timeLog.beginTime,
      taskId: timeLog.taskId,
      duration: DateTime.now().difference(timeLog.beginTime),
    );

    await _timeLoggingRepository.createTimeLog(finalTimeLog);

    emit(InitializedState(
        parentTask: currentState.parentTask, task: currentState.task));
  }
}
