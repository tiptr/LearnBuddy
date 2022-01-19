import 'package:learning_app/constants/settings_constants.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';

class Config {
  late final int _countUntilLongerBreak;
  late Map _pomodoroMinutes;

  Config() {
    _pomodoroMinutes = {
      PomodoroMode.concentration: (SharedPreferencesData.concentrationMinutes ??
              defaultConcentrationMinutes) *
          60,
      PomodoroMode.shortBreak:
          (SharedPreferencesData.breakMinutes ?? defaultBreakMinutes) * 60,
      PomodoroMode.longBreak: (SharedPreferencesData.longerBreakMinutes ??
              defaultLongerBreakMinutes) *
          60,
    };
    _countUntilLongerBreak = (SharedPreferencesData.countUntilLongerBreak ??
        defaultCountUntilLongerBreak);
  }

  Map getPomodoroMinutes() => _pomodoroMinutes;
  int getCountUntilLongerBreak() => _countUntilLongerBreak;
  int getPhaseCount() => _countUntilLongerBreak * 2;
}
