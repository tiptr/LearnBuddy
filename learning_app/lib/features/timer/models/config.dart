import 'package:learning_app/features/timer/models/pomodoro_mode.dart';

class Config {
  late final int _countUntilLongerBreak;
  var _pomodoroMinutes = Map();

  Config(concentrationMinutes, breakMinutes, longerBreakMinutes, countUntilLongerBreak){
    _pomodoroMinutes = {
      PomodoroMode.concentration: concentrationMinutes * 60,
      PomodoroMode.shortBreak: breakMinutes* 60,
      PomodoroMode.longBreak: longerBreakMinutes* 60,
    };
    _countUntilLongerBreak = countUntilLongerBreak;
  }


  Map getPomodoroMinuets() => _pomodoroMinutes;
  int getCountUntilLongerBreak() => _countUntilLongerBreak;



}