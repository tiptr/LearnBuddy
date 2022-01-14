import 'package:flutter/material.dart';

/// Contains multiple instances of usable [ColorScheme] objects.
/// The class [ColorScheme] does not contain all attributes used in the code,
/// and therefore, the other values are declared in the extension
/// [CustomColorScheme] down below.
class ColorSchemes {
  /// Feature Relase: dark mode
  static ColorScheme darkColorScheme() {
    ColorScheme darkTheme = const ColorScheme.dark();
    darkTheme.setCustomAttributes(/*...*/);
    return darkTheme;
  }

  /// Returns the default theme
  static ColorScheme defaultColorScheme() {
    ColorScheme theme = ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF3444CF),
          secondary: const Color(0xFF9E5EE1),
          background: const Color(0xFFF9F9FE),
          onPrimary: const Color(0xffffffff),
          onSecondary: const Color(0xffffffff),
          onBackground: const Color(0xff000000),
        );
    theme.setCustomAttributes(
      greyOutOverlayColor: const Color(0xB8FFFFFF),
      bottomNavigationBarUnselectedItemColor: Colors.grey,
      cancelColor: Colors.grey,
      timerProgressIndicatorCompletedSessionColor: Colors.blue,
      timerProgressIndicatorUnCompletedSessionColor: Colors.grey,
      noCategoryDefaultColor: Colors.grey,
    );
    return theme;
  }
}

/// Extends the [ColorScheme} class with all necessary attributes, that are not
/// originally in the [ColorScheme] class. The attributes can be null. In that
/// case, defaults are returned in the getters.
extension CustomColorScheme on ColorScheme {
  static Color? _greyOutOverlayColor;
  static Color? _bottomNavigationBarUnselectedItemColor;
  static Color? _cancelColor;

  static Color? _timerProgressIndicatorCompletedSessionColor;
  static Color? _timerProgressIndicatorUnCompletedSessionColor;

  static Color? _noCategoryDefaultColor;

  /// Sets the custom attributes that are not contained in the ColorScheme class
  setCustomAttributes({
    Color? greyOutOverlayColor,
    Color? bottomNavigationBarUnselectedItemColor,
    Color? cancelColor,
    Color? timerProgressIndicatorCompletedSessionColor,
    Color? timerProgressIndicatorUnCompletedSessionColor,
    Color? noCategoryDefaultColor,
  }) {
    //Using ??= to allow multiple calls of this method, without overriding set values
    _greyOutOverlayColor ??= greyOutOverlayColor;

    _bottomNavigationBarUnselectedItemColor ??=
        bottomNavigationBarUnselectedItemColor;

    _cancelColor ??= cancelColor;

    _timerProgressIndicatorCompletedSessionColor ??=
        timerProgressIndicatorCompletedSessionColor;

    _timerProgressIndicatorUnCompletedSessionColor ??=
        timerProgressIndicatorUnCompletedSessionColor;

    _noCategoryDefaultColor ??= noCategoryDefaultColor;
  }

  // Getters of all attributes with defaults if not set. Default red, to clearly
  // see which color was not set.
  Color get greyOutOverlayColor => _greyOutOverlayColor ?? Colors.red;
  Color get cancelColor => _cancelColor ?? Colors.red;
  Color get bottomNavigationBarUnselectedItemColor =>
      _bottomNavigationBarUnselectedItemColor ?? Colors.red;
  Color get timerProgressIndicatorCompletedSessionColor =>
      _timerProgressIndicatorCompletedSessionColor ?? Colors.red;
  Color get timerProgressIndicatorUnCompletedSessionColor =>
      _timerProgressIndicatorUnCompletedSessionColor ?? Colors.red;
  Color get noCategoryDefaultColor => _noCategoryDefaultColor ?? Colors.grey;
}
