import 'package:bloc/bloc.dart';
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

  ThemeName toggleTheme() {
    ThemeName newThemeName =
        state.themeName == ThemeName.light ? ThemeName.dark : ThemeName.light;
    setToTheme(newThemeName);
    return newThemeName;
  }

  void setToTheme(ThemeName themeName) async {
    if (state.themeName != themeName) {
      emit(themeName == ThemeName.light
          ? ThemeState.lightThemeState
          : ThemeState.darkThemeState);
    }
  }
}
