import 'package:learning_app/features/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  static late SharedPreferences _prefs;

  static const _namePrefKey = "personal.name";
  static const _agePrefKey = "personal.age";
  static const _themePrefKey = "themeName";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static String? get userName => _prefs.getString(_namePrefKey);
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

  static int? get concentrationMinutes => null;
  static int? get breakMinutes => null;
  static int? get longerBreakMinutes => null;
  static int? get countUntilLongerBreak => null;

  static Future storeUserName(String? name) async =>
      await _prefs.setString(_namePrefKey, name ?? "");

  static Future storeUserAge(int? age) async =>
      await _prefs.setInt(_agePrefKey, age ?? -1);

  static Future storeThemeName(ThemeName? themeName) async => await _prefs
      .setString(_themePrefKey, themeName == null ? "" : themeName.name);
}
