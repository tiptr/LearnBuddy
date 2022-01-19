import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes.dart';
import 'bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeState initialState}) : super(initialState);

  void setToLightTheme() {
    setToTheme(ThemeName.light);
  }

  void setToDarkTheme() {
    setToTheme(ThemeName.dark);
  }

  void toggleTheme() {
    setToTheme(
        state.themeName == ThemeName.light ? ThemeName.dark : ThemeName.light);
  }

  void setToTheme(ThemeName themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Themes.prefKey, themeName.name);
    if (state.themeName != themeName) {
      emit(themeName == ThemeName.light
          ? ThemeState.lightThemeState
          : ThemeState.darkThemeState);
    }
  }
}
