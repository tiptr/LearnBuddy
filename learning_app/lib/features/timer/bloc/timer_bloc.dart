import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/features/timer/models/config.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/models/ticker.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';
import 'package:learning_app/util/injection.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker = const Ticker();
  //final TimeLoggingBloc _timeLoggingBloc = getIt<TimeLoggingBloc>();

  StreamSubscription<int>? _tickerSubscription;

  late final TimeLoggingBloc timeLoggingBloc;

  TimerBloc({required this.timeLoggingBloc}) : super(TimerInitial()) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerSkip>(_onSkipped);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(state.onStarted());
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(secs: state._duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
    timeLoggingBloc.add(StartTimeLoggingEvent(beginTime: DateTime.now()));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(
              event.duration, state._pomodoroMode, state._countPhase)
          : TimerRunComplete(
              event.duration, state._pomodoroMode, state._countPhase),
    );

    // Notify the Time Logging Bloc that it has to update
    if (state._pomodoroMode == PomodoroMode.concentration) {
      timeLoggingBloc
          .add(const TimeNoticeEvent(duration: Duration(seconds: 1)));
    }
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.cancel();
      emit(state.onPaused());
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      //state hat remaining duration
      _tickerSubscription = _ticker
          .tick(secs: state._duration)
          .listen((duration) => add(TimerTicked(duration: duration)));
      emit(state.onResumed());
    }
  }

  void _onSkipped(TimerSkip event, Emitter<TimerState> emit) {
    emit(state.onSkipPhase());
    _tickerSubscription?.cancel();
  }
}
