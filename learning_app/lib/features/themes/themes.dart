import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

enum ThemeName {
  light,
  dark,
}

class Themes {
  static ScrollbarThemeData scrollBarTheme = ScrollbarThemeData(
    isAlwaysShown: false,
    thickness: MaterialStateProperty.all(10),
    radius: const Radius.circular(10),
    minThumbLength: 50,
  );

  static ThemeData lightThemeData() {
// Must be declared explicitly to be passed on to the TextTheme, which relies
// on the colorScheme
    final ColorScheme lightColorScheme = ColorSchemes.lightColorScheme();
    final TextTheme lightTextTheme =
        TextThemes.defaultTextTheme(lightColorScheme);
    return ThemeData.light().copyWith(
      scrollbarTheme: scrollBarTheme,
      colorScheme: lightColorScheme,
      textTheme:
          lightTextTheme, // necessary for native Components like DatePicker or DurationPicker:
      // Date and Durationpicker background
      dialogBackgroundColor: lightColorScheme.cardColor,
      // ColorPicker hex-textfield label
      hintColor: lightColorScheme.onBackgroundSoft,
      // DurationPicker innercircle color
      canvasColor: lightColorScheme.cardColor,
      // DurationPicker thick circle border
      backgroundColor: lightColorScheme.tertiary,
    );
  }

  static ThemeData darkThemeData() {
// Must be declared explicitly to be passed on to the TextTheme, which relies
// on the colorScheme

    final ColorScheme darkColorScheme = ColorSchemes.darkColorScheme();
    final TextTheme darkTextTheme =
        TextThemes.defaultTextTheme(darkColorScheme);
    return ThemeData.dark().copyWith(
      scrollbarTheme: scrollBarTheme,
      colorScheme: darkColorScheme,
      textTheme:
          darkTextTheme, // necessary for native Components like DatePicker or DurationPicker:
      // Date and Durationpicker background
      dialogBackgroundColor: darkColorScheme.cardColor,
      // ColorPicker hex-textfield label
      hintColor: darkColorScheme.onBackgroundSoft,
      // DurationPicker innercircle color
      canvasColor: darkColorScheme.cardColor,
      // DurationPicker thick circle border
      backgroundColor: darkColorScheme.tertiary,
    );
  }
}
