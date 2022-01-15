import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class TextThemes {
  static TextTheme defaultTextTheme(ColorScheme colorScheme) {
    TextTheme theme = ThemeData().textTheme;
    theme.setCustomColorScheme(colorScheme);
    return ThemeData().textTheme.copyWith(
        // If the default attributes of the TextTheme (headline1-6, etc.) want to
        // be used, they can be set here. Custom attributes are defined in the
        // extension
        );
  }
}

/// All basic Textstyles are returned with normal Fontweight and with Color
/// [onBackground], unless only used in one location which can be infered by the
/// style getter name. Certain properties of the TextStyles can be changed with
/// the extension on TextStyle down below.
/// The TextStyles are named like the HTML headlines. [TextStyle1] is the largest
/// TextStyle, [TextStyle4] is the smallest one.
extension CustomTextTheme on TextTheme {
  static late ColorScheme _colorScheme;
  setCustomColorScheme(ColorScheme colorScheme) {
    _colorScheme = colorScheme;
    // I don't know why, but this doesn't work with a static methode, that's why
    // a dummy TextStyle object is instantiated.
    const TextStyle().setCustomColorScheme(colorScheme);
  }

  // Basic TextStyles
  TextStyle get textStyle1 => TextStyle(
      fontFamily: 'Open Sans',
      inherit: true,
      fontSize: 26,
      overflow: TextOverflow.ellipsis,
      color: _colorScheme.onBackground);
  TextStyle get textStyle2 => textStyle1.copyWith(fontSize: 16);
  TextStyle get textStyle3 => textStyle1.copyWith(fontSize: 14);
  TextStyle get textStyle4 => textStyle1.copyWith(fontSize: 12);

  // Explicit TextStyles for concrete uses
  TextStyle get mainPageTitleStyle => textStyle1.withBold.withPrimary;
  TextStyle get pomodoroTimeDisplayStyle => textStyle1.copyWith(fontSize: 52);
  TextStyle get settingsInfoTextStyle => textStyle4.copyWith(
      height: 1.6, overflow: TextOverflow.visible, letterSpacing: 0.2);
}

/// This extension allows easily changing different properties of a given
/// TextStyle
extension CustomStyle on TextStyle {
  static late ColorScheme _colorScheme;

  setCustomColorScheme(ColorScheme colorScheme) {
    _colorScheme = colorScheme;
  }

  // Same style but in different text colors
  TextStyle get withOnBackgroundHard =>
      copyWith(color: _colorScheme.onBackgroundHard);
  TextStyle get withOnBackgroundSoft =>
      copyWith(color: _colorScheme.onBackgroundSoft);

  // Same style but in different theme colors
  TextStyle get withPrimary => copyWith(color: _colorScheme.primary);
  TextStyle get withOnPrimary => copyWith(color: _colorScheme.onPrimary);
  TextStyle get withSecondary => copyWith(color: _colorScheme.secondary);
  TextStyle get withOnSecondary => copyWith(color: _colorScheme.onSecondary);
  TextStyle get withTertiary => copyWith(color: _colorScheme.tertiary);
  TextStyle get withOnTertiary => copyWith(color: _colorScheme.onTertiary);

  // Same style but bold
  TextStyle get withBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle withOverflow(TextOverflow overflow) {
    return copyWith(overflow: overflow);
  }
}
