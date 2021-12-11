part of 'timer_bloc.dart';

abstract class TimerState {
  final Config _config = Config(1, 5, 15, 2);
  late int _countPhase; // Phase count is between 0 and (2 * countUntilLongerBreak - 1)
  late PomodoroMode _pomodoroMode;
  late int _duration;

  TimerState onStarted();
  TimerState onPaused();
  TimerState onResumed();

  //onSkip is available everywhere. In TimerRunComplete it equals a dismiss!
  TimerState onSkipPhase() {
    incrementPhaseCount();
    PomodoroMode nextMode = getNextPomodoroMode();
    if(_countPhase == (2 * _config.getCountUntilLongerBreak()) - 1) {
      // return to Initial State if Pomodoro Cycle is done.
      return TimerInitial();
    }
    return TimerInitialInSession(nextMode, _countPhase);
  }


  // returns true if the session should continue -> _count_phase != 0
  void incrementPhaseCount(){
    _countPhase++;
  }

  PomodoroMode getNextPomodoroMode() {
    if (_countPhase % 2 == 0) {
      return PomodoroMode.concentration;
    }
    if(_countPhase == _config.getCountUntilLongerBreak() * 2 - 1 ){
      return PomodoroMode.longBreak;
    }
    return PomodoroMode.shortBreak;
  }

  int getDuration() => _duration;
  PomodoroMode getPomodoroMode() => _pomodoroMode;
  Config getConfig() => _config;
  int getCountPhase() => _countPhase;


}


class TimerInitial extends TimerState {
  TimerInitial() {
    _countPhase = 0;
    _pomodoroMode = PomodoroMode.concentration;
    _duration = _config.getPomodoroMinuets()[_pomodoroMode];
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

class TimerInitialInSession extends TimerState{
  TimerInitialInSession(PomodoroMode pomodoroMode, int countPhase){
    _pomodoroMode = pomodoroMode;
    _duration = _config.getPomodoroMinuets()[_pomodoroMode];
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


class TimerRunInProgress extends TimerState {
  TimerRunInProgress(int duration, PomodoroMode pomodoroMode, int countPhase){
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


class TimerRunPause extends TimerState {
  TimerRunPause(int duration, PomodoroMode pomodoroMode, int countPhase){
    _pomodoroMode = pomodoroMode;
    _duration = duration;
    _countPhase = countPhase;
  }

  @override
  String toString() => 'TimerRunPause { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';


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


class TimerRunComplete extends TimerState {
  TimerRunComplete(){
    _duration = 0;

  }

  @override
  String toString() => 'TimerRunComplete { duration: $_duration, pomodoroMode: $_pomodoroMode, count: $_countPhase }';

  @override
  TimerState onPaused() {
    throw InvalidStateException();
  }

  @override
  TimerState onResumed() {
    throw InvalidStateException();
  }

  @override
  TimerState onSkipPhase() {
    throw InvalidStateException();
  }

  @override
  TimerState onStarted() {
    throw InvalidStateException();
  }
}




