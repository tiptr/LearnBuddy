import 'package:bloc/bloc.dart';
import '../themes.dart';
import 'bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeState initialState}) : super(initialState);

  void setToLightTheme() {
    emit(ThemeState(
        themeName: ThemeName.light, themeData: Themes.lightThemeData()));
  }

  void setToDarkTheme() {
    emit(ThemeState(
        themeName: ThemeName.dark, themeData: Themes.darkThemeData()));
  }
  // yield ThemeState(themeData: Themes.[event.theme]);
}
