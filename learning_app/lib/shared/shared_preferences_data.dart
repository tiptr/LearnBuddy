import 'package:learning_app/features/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  static late SharedPreferences _prefs;

  static const _namePrefKey = "personal.name";
  static const _agePrefKey = "personal.age";
  static const _concentrationDurationPrefKey = "pomodoro.concentration";
  static const _shortBreakPrefKey = "pomodoro.shortBreak";
  static const _longBreakPrefKey = "pomodoro.longBreak";
  static const _phaseCountUntilBreakPrefKey = "pomodoro.cycleCount";
  static const _themePrefKey = "theme.themeName";
  static const _displayLeisureOnDashboardPrefKey = "dashboard.displayLeisure";
  static const _taskCountOnDashboardPrefKey = "dashboard.taskCount";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static String? get userName => _prefs.getString(_namePrefKey);
  static bool? get displayLeisureOnDashboard =>
      _prefs.getBool(_displayLeisureOnDashboardPrefKey);
  static int? get taskCountOnDashboard =>
      _prefs.getInt(_taskCountOnDashboardPrefKey);
  static int? get userAge {
    int? age = _prefs.getInt(_agePrefKey);
    return age == null || age == -1 ? null : age;
  }

  static ThemeName? get themeName {
    String? pref = _prefs.getString(_themePrefKey);
    if (pref == null || pref == "") return null;
    return ThemeName.values.firstWhere(
      (mode) => mode.name == pref,
      // if a non null theme name is returned from the store, that doesn't
      // belong to a valid theme, the lightTheme is returned.
      orElse: () => ThemeName.light,
    );
  }

  static int? get concentrationMinutes =>
      _prefs.getInt(_concentrationDurationPrefKey);
  static int? get breakMinutes => _prefs.getInt(_shortBreakPrefKey);
  static int? get longerBreakMinutes => _prefs.getInt(_longBreakPrefKey);
  static int? get countUntilLongerBreak =>
      _prefs.getInt(_phaseCountUntilBreakPrefKey);

  static Future storeUserName(String? name) async =>
      await _prefs.setString(_namePrefKey, name ?? "");

  static Future storeUserAge(int? age) async =>
      await _prefs.setInt(_agePrefKey, age ?? -1);

  static Future storeThemeName(ThemeName? themeName) async => await _prefs
      .setString(_themePrefKey, themeName == null ? "" : themeName.name);
  static Future storeTaskCountOnDashboard(int taskCount) async =>
      await _prefs.setInt(_taskCountOnDashboardPrefKey, taskCount);
  static Future storeDisplayLeisureOnDashboard(bool displayLeisure) async =>
      await _prefs.setBool(_displayLeisureOnDashboardPrefKey, displayLeisure);

  static Future storeConcentrationMinutes(
          Duration concentrationMinutes) async =>
      await _prefs.setInt(
          _concentrationDurationPrefKey, concentrationMinutes.inMinutes);

  static Future storeBreakMinutes(Duration shortBreakMinutes) async =>
      await _prefs.setInt(_shortBreakPrefKey, shortBreakMinutes.inMinutes);

  static Future storeLongerBreakMinutes(Duration longBreakMinutes) async =>
      await _prefs.setInt(_longBreakPrefKey, longBreakMinutes.inMinutes);

  static Future storeCountUntilLongerBreak(int cycleCount) async =>
      await _prefs.setInt(_phaseCountUntilBreakPrefKey, cycleCount);

  static void resetSettings() {
    _prefs.remove(_agePrefKey);
    _prefs.remove(_namePrefKey);
    _prefs.remove(_displayLeisureOnDashboardPrefKey);
    _prefs.remove(_taskCountOnDashboardPrefKey);
    _prefs.remove(_concentrationDurationPrefKey);
    _prefs.remove(_longBreakPrefKey);
    _prefs.remove(_shortBreakPrefKey);
    _prefs.remove(_phaseCountUntilBreakPrefKey);
    _prefs.remove(_themePrefKey);
  }
}
