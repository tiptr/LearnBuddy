import 'package:flutter/material.dart';

const primaryLight = Color(0xFF3444CF);
const primaryDark = Colors.red; //Color(0xFF7AD7Ff);

const secondaryLight = Color(0xFF9E5EE1);
const secondaryDark = Color(0xFFF5F232);

const orangeGradient = LinearGradient(
    colors: [Color(0xFFFFCC00), Color(0xFFEE2222)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
const blueGradient = LinearGradient(
    colors: [Color(0xFF2CDCA1), Color(0xFF638DE7)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
const purpleGradient = LinearGradient(
    colors: [Color(0xFFC56BD7), Color(0xFF5848BB)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);

/// Contains multiple instances of usable [ColorScheme] objects.
/// The class [ColorScheme] does not contain all attributes used in the code,
/// and therefore, the other values are declared in the extension
/// [CustomColorScheme] down below.
class ColorSchemes {
  /// Feature Relase: dark mode
  static ColorScheme darkColorScheme() {
    const backgroundColor = Color(0xFF222428);
    ColorScheme darkTheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: primaryDark,
      secondary: secondaryDark,
      background: backgroundColor,
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF000000),
      onBackground: const Color(0xFFAAAAAA),
      //necessary for native components such as DatePicker, DurationPicker
      surface: backgroundColor,
      onSurface: const Color(0xFFCCCCFF),
    );
    return darkTheme;
  }

  /// Returns the default theme
  static ColorScheme lightColorScheme() {
    const backgroundColor = Color(0xFFF9F9FE);
    const onBackgroundColor = Color(0xFF636573);
    ColorScheme theme = const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: primaryLight,
      secondary: secondaryLight,
      background: backgroundColor,
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
      "subtleBackgroundGrey": const Color(0xFF4F4F5F),
      "cardColor": const Color(0xFF2b2b34),
      "shadowColor": const Color(0xFF000000),
      "success": const Color(0xFF4BB543),
      "onError": const Color(0xFFFF9494),
      "primaryGradient": orangeGradient,
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
      "success": const Color(0xFF4BB543),
      "onError": const Color(0xFFFF9494),
      "primaryGradient": orangeGradient,
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

  Color get success => customs[brightness]!["success"]!;

  Color get subtleBackgroundGrey =>
      customs[brightness]!["subtleBackgroundGrey"]!;

  Color get shadowColor => customs[brightness]!["shadowColor"]!;

  // Independent of mode
  Color get checkColor => const Color(0xFFFFFFFF);
  LinearGradient get noColorGradient =>
      LinearGradient(colors: [onBackgroundSoft, onBackgroundSoft]);

  bool get isDark => customs[brightness]!["isDark"]!;

  LinearGradient get primaryGradient =>
      customs[brightness]!["primaryGradient"]!;
}
