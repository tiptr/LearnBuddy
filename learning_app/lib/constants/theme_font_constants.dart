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
  }

  // Basic TextStyles
  TextStyle get textStyle1 => TextStyle(
      fontFamily: 'Open Sans',
      inherit: false,
      fontSize: 22,
      overflow: TextOverflow.ellipsis,
      color: _colorScheme.onBackground);
  TextStyle get textStyle2 => textStyle1.merge(const TextStyle(fontSize: 16));
  TextStyle get textStyle3 => textStyle1.merge(const TextStyle(fontSize: 14));
  TextStyle get textStyle4 => textStyle1.merge(const TextStyle(fontSize: 12));

  // Explicit TextStyles for concrete uses
  TextStyle get mainPageTitleStyle => textStyle1.withBold.withOnBackgroundHard;
  TextStyle get cardTitleStyle => const TextStyle();
  TextStyle get cardSubTitleStyle => const TextStyle();
}

/// This extension allows easily changing different properties of a given
/// TextStyle
extension CustomStyle on TextStyle {
  static ColorScheme colorScheme = ThemeData().colorScheme;

  // Same style but in different text colors
  TextStyle get withOnBackgroundHard =>
      merge(TextStyle(color: colorScheme.onBackgroundHard));
  TextStyle get withOnBackgroundSoft =>
      merge(TextStyle(color: colorScheme.onBackgroundSoft));

  // Same style but in different theme colors
  TextStyle get withPrimary => merge(TextStyle(color: colorScheme.primary));
  TextStyle get withOnPrimary => merge(TextStyle(color: colorScheme.onPrimary));
  TextStyle get withSecondary => merge(TextStyle(color: colorScheme.secondary));
  TextStyle get withOnSecondary =>
      merge(TextStyle(color: colorScheme.onSecondary));
  TextStyle get withTertiary => merge(TextStyle(color: colorScheme.tertiary));
  TextStyle get withOnTertiary =>
      merge(TextStyle(color: colorScheme.onTertiary));

  // Same style but bold
  TextStyle get withBold => merge(const TextStyle(fontWeight: FontWeight.bold));

  TextStyle withOverflow(TextOverflow overflow) {
    return merge(TextStyle(overflow: overflow));
  }
}
