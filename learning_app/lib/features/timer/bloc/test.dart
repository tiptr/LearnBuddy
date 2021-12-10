import 'package:learning_app/features/timer/models/Config.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';

void main() {
  var cofig = Config(30, 5, 2, 15);
  print(cofig.getPomodoroMinuets()[PomodoroMode.concentration]);
}