import 'package:bloc/bloc.dart';
import '../themes.dart';
import 'bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeState initialState}) : super(initialState);

  void setToLightTheme() {
    emit(ThemeState(
      themeName: ThemeName.light,
      themeData: Themes.lightThemeData(),
      isDark: false,
    ));
  }

  void setToDarkTheme() {
    emit(ThemeState(
      themeName: ThemeName.dark,
      themeData: Themes.darkThemeData(),
      isDark: true,
    ));
  }

  void toggleTheme() {
    emit(
      state.themeName == ThemeName.light
          ? ThemeState(
              themeName: ThemeName.dark,
              themeData: Themes.darkThemeData(),
              isDark: true,
            )
          : ThemeState(
              themeName: ThemeName.light,
              themeData: Themes.lightThemeData(),
              isDark: false,
            ),
    );
  }
}
