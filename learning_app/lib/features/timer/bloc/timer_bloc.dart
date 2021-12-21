import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/timer/exceptions/invalid_state_exception.dart';
import 'package:learning_app/features/timer/models/config.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/models/ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker = const Ticker();

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc() : super(TimerInitial()) {
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
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(
              event.duration, state._pomodoroMode, state._countPhase)
          : TimerRunComplete(
              event.duration, state._pomodoroMode, state._countPhase),
    );
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(state.onPaused());
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(state.onResumed());
    }
  }

  void _onSkipped(TimerSkip event, Emitter<TimerState> emit) {
    emit(state.onSkipPhase());
    _tickerSubscription?.cancel();
  }
}
