part of 'timer_bloc.dart';

abstract class TimerState {
  final Config _config = TimerBloc.config;
  late int
      _countPhase; // Phase count is between 0 and (2 * countUntilLongerBreak - 1)
  late PomodoroMode _pomodoroMode;
  late int _duration;

  // Every State has to implement these Functions.
  // Not every method in any state makes sense -> throw InvalidStateException
  TimerState onStarted();
  TimerState onPaused();
  TimerState onResumed();

  //onSkip is available everywhere. In TimerRunComplete it equals a dismiss!
  TimerState onSkipPhase() {
    _countPhase++;
    PomodoroMode nextMode = _getNextPomodoroMode();
    if (_countPhase == (2 * _config.getCountUntilLongerBreak())) {
      // return to Initial State if Pomodoro Cycle is done.
      return TimerInitial();
    }
    return TimerInitialInSession(nextMode, _countPhase);
  }

  PomodoroMode _getNextPomodoroMode() {
    if (_countPhase % 2 == 0) {
      return PomodoroMode.concentration;
    }
    if (_countPhase == _config.getCountUntilLongerBreak() * 2 - 1) {
      return PomodoroMode.longBreak;
    }
    return PomodoroMode.shortBreak;
  }

  //getters
  int getDuration() => _duration;
  PomodoroMode getPomodoroMode() => _pomodoroMode;
  Config getConfig() => _config;
  int getCountPhase() => _countPhase;
}

// Initial State
// Start and Skip are available
class TimerInitial extends TimerState {
  TimerInitial() {
    _countPhase = 0;
    _pomodoroMode = PomodoroMode.concentration;
    _duration = _config.getPomodoroMinutes()[_pomodoroMode];
  }

  @override
  String toString() =>
      'TimerInitial { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onStarted() {
    return TimerRunInProgress(_duration, _pomodoroMode, _countPhase);
  }

  @override
  TimerState onPaused() {
    throw InvalidStateException();
  }

  @override
  TimerState onResumed() {
    throw InvalidStateException();
  }
}

// Timer is in Session, but at the start of a Phase
// Start and Skip are available
class TimerInitialInSession extends TimerState {
  TimerInitialInSession(PomodoroMode pomodoroMode, int countPhase) {
    _pomodoroMode = pomodoroMode;
    _duration = _config.getPomodoroMinutes()[_pomodoroMode];
    _countPhase = countPhase;
  }
  @override
  String toString() =>
      'TimerInitialInSession { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onPaused() {
    throw InvalidStateException();
  }

  @override
  TimerState onResumed() {
    throw InvalidStateException();
  }

  @override
  TimerState onStarted() {
    return TimerRunInProgress(_duration, _pomodoroMode, _countPhase);
  }
}

// Timer is Running
// Skip and Pause are available
class TimerRunInProgress extends TimerState {
  TimerRunInProgress(int duration, PomodoroMode pomodoroMode, int countPhase) {
    _pomodoroMode = pomodoroMode;
    _duration = duration;
    _countPhase = countPhase;
  }
  @override
  String toString() =>
      'TimerRunInProgress { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onPaused() {
    return TimerRunPause(_duration, _pomodoroMode, _countPhase);
  }

  @override
  TimerState onResumed() {
    throw InvalidStateException();
  }

  @override
  TimerState onStarted() {
    throw InvalidStateException();
  }
}

// The timer is in Pause
// Skip and Resume are available
class TimerRunPause extends TimerState {
  TimerRunPause(int duration, PomodoroMode pomodoroMode, int countPhase) {
    _pomodoroMode = pomodoroMode;
    _duration = duration;
    _countPhase = countPhase;
  }

  @override
  String toString() =>
      'TimerRunPause { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onResumed() {
    return TimerRunInProgress(_duration, _pomodoroMode, _countPhase);
  }

  @override
  TimerState onPaused() {
    throw InvalidStateException();
  }

  @override
  TimerState onStarted() {
    throw InvalidStateException();
  }
}

// The timer runs into negaitve numbers
// only skip is available
class TimerRunComplete extends TimerState {
  TimerRunComplete(int duration, PomodoroMode pomodoroMode, int countPhase) {
    _duration = duration;
    _pomodoroMode = pomodoroMode;
    _countPhase = countPhase;
  }

  @override
  String toString() =>
      'TimerRunComplete { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onPaused() {
    throw InvalidStateException();
  }

  @override
  TimerState onResumed() {
    throw InvalidStateException();
  }

  @override
  TimerState onStarted() {
    throw InvalidStateException();
  }
}
