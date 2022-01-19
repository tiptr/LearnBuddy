import 'package:flutter/material.dart';

/// Contains multiple instances of usable [ColorScheme] objects.
/// The class [ColorScheme] does not contain all attributes used in the code,
/// and therefore, the other values are declared in the extension
/// [CustomColorScheme] down below.
class ColorSchemes {
  /// Feature Relase: dark mode
  static ColorScheme darkColorScheme() {
    const backgroundColor = Color(0xFF212121);
    ColorScheme darkTheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: const Color(0xFF00FC82),
      secondary: const Color(0xFFF5F232),
      background: backgroundColor,
      onPrimary: const Color(0xFF000000),
      onSecondary: const Color(0xFF000000),
      onBackground: const Color(0xFFAAAAAA),
      //necessary for native components such as DatePicker, DurationPicker
      surface: backgroundColor,
      onSurface: const Color(0xFFFFFFFF),
    );
    return darkTheme;
  }

  /// Returns the default theme
  static ColorScheme lightColorScheme() {
    const backgroundColor = Color(0xFFF9F9FE);
    const onBackgroundColor = Color(0xFF636573);
    ColorScheme theme = const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFF3444CF),
      secondary: const Color(0xFF9E5EE1),
      background: const Color(0xFFF9F9FE),
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFFFFFFFF),
      onBackground: onBackgroundColor,
      //necessary for native components such as DatePicker, DurationPicker
      surface: backgroundColor,
      onSurface: const Color(0xFF40424A),
    );
    return theme;
  }
}

/// Extends the [ColorScheme} class with all necessary attributes, that are not
/// originally in the [ColorScheme] class. The attributes can be null. In that
/// case, defaults are returned in the getters.
extension CustomColorScheme on ColorScheme {
  static final Map<Brightness, Map> customs = {
    Brightness.dark: {
      "greyOutOverlayColor": const Color(0xB8161616),
      "noCategoryDefaultColor": const Color(0xFFAAAAAA),
      "onBackgroundHard": const Color(0xFFFFFFFF),
      "onBackgroundSoft": const Color(0xFF636573),
      "tertiary": const Color(0xFF7AD7F0),
      "onTertiary": const Color(0xFF000000), // Same as onBackgroundHard
      "subtleBackgroundGrey": const Color(0xFF3F3F3F),
      "cardColor": const Color(0xFF303030),
      "shadowColor": const Color(0xFF000000),
      "onSuccess": const Color(0xFF4BB543),
      "onError": const Color(0xFFFF9494),
      "isDark": true,
    },
    Brightness.light: {
      "greyOutOverlayColor": const Color(0xB8FFFFFF),
      "noCategoryDefaultColor": const Color(0xFF636573),
      "onBackgroundHard": const Color(0xFF40424A),
      "onBackgroundSoft": const Color(0xFF949597),
      "tertiary": const Color(0xFF39BBD1),
      "onTertiary": const Color(0xFF40424A), // Same as onBackgroundHard
      "subtleBackgroundGrey": const Color(0xFFEAECFA),
      "cardColor": const Color(0xFFFFFFFF),
      "shadowColor": const Color(0xFF000000).withOpacity(0.8),
      "onSuccess": const Color(0xFF4BB543),
      "onError": const Color(0xFFFF9494),
      "isDark": false,
    }
  };

  Color get greyOutOverlayColor => customs[brightness]!["greyOutOverlayColor"]!;

  Color get noCategoryDefaultColor =>
      customs[brightness]!["noCategoryDefaultColor"]!;

  Color get cardColor => customs[brightness]!["cardColor"]!;

  Color get tertiary => customs[brightness]!["tertiary"]!;

  Color get onTertiary => customs[brightness]!["onTertiary"]!;

  Color get onBackgroundHard => customs[brightness]!["onBackgroundHard"]!;

  Color get onBackgroundSoft => customs[brightness]!["onBackgroundSoft"]!;

  Color get subtleBackgroundGrey =>
      customs[brightness]!["subtleBackgroundGrey"]!;

  Color get shadowColor => customs[brightness]!["shadowColor"]!;

  // Independent of mode
  Color get checkColor => const Color(0xFFFFFFFF);

  bool get isDark => customs[brightness]!["isDark"]!;
}
