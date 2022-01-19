import 'package:learning_app/features/timer/models/pomodoro_mode.dart';

class Config {
  late final int _countUntilLongerBreak;
  late Map _pomodoroMinutes;

  Config(
    concentrationMinutes,
    breakMinutes,
    longerBreakMinutes,
    countUntilLongerBreak,
  ) {
    _pomodoroMinutes = {
      PomodoroMode.concentration: concentrationMinutes * 5,
      PomodoroMode.shortBreak: breakMinutes * 5,
      PomodoroMode.longBreak: longerBreakMinutes * 60,
    };
    _countUntilLongerBreak = countUntilLongerBreak;
  }

  Map getPomodoroMinutes() => _pomodoroMinutes;
  int getCountUntilLongerBreak() => _countUntilLongerBreak;
  int getPhaseCount() => _countUntilLongerBreak * 2;
}
