import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../themes.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeName themeName;
  final bool isDark;

  const ThemeState({
    required this.themeData,
    required this.themeName,
    required this.isDark,
  }) : super();

  @override
  List<Object?> get props => [themeName];

  static ThemeState get lightThemeState => ThemeState(
        themeData: Themes.lightThemeData(),
        themeName: ThemeName.light,
        isDark: false,
      );

  static ThemeState get darkThemeState => ThemeState(
        themeData: Themes.darkThemeData(),
        themeName: ThemeName.dark,
        isDark: true,
      );

  /// Returns a ThemeState belonging to a ThemeName. If the ThemeName doesn't
  /// match a ThemeState, the light theme ThemeState is returned.
  static ThemeState fromName(ThemeName themeName) {
    if (themeName == ThemeName.dark) {
      return darkThemeState;
    }
    return lightThemeState;
  }
}
