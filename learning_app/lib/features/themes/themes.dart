import 'package:flutter/material.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

enum ThemeName {
  light,
  dark,
}

class Themes {
//   final ThemeData themeData = ThemeData().copyWith(
//     scrollbarTheme: ScrollbarThemeData(
//       isAlwaysShown: false,
//       thickness: MaterialStateProperty.all(10),
//       radius: const Radius.circular(10),
//       minThumbLength: 50,
//     ),
//   );
// // Must be declared explicitly to be passed on to the TextTheme, which relies
// // on the colorScheme
//   final ColorScheme lightColorScheme = ColorSchemes.darkColorScheme();
//   final TextTheme lightTextTheme =
//       TextThemes.defaultTextTheme(lightColorScheme);
//   final ColorScheme darkColorScheme = ColorSchemes.darkColorScheme();
//   final TextTheme darkTextTheme = TextThemes.defaultTextTheme(darkColorScheme);

//   final ThemeData lightThemeData = themeData.copyWith(
//       brightness: Brightness.light,
//       colorScheme: lightColorScheme,
//       textTheme:
//           lightTextTheme, // necessary for native Components like DatePicker or DurationPicker:
//       // Date and Durationpicker background
//       dialogBackgroundColor: lightColorScheme.cardColor,
//       // ColorPicker hex-textfield label
//       hintColor: lightColorScheme.onBackgroundSoft,
//       // DurationPicker innercircle color
//       canvasColor: lightColorScheme.cardColor,
//       // DurationPicker thick circle border
//       backgroundColor: lightColorScheme.tertiary);

//   final ThemeData darkThemeData = themeData.copyWith(
//       brightness: Brightness.dark,
//       colorScheme: darkColorScheme,
//       textTheme:
//           darkTextTheme, // necessary for native Components like DatePicker or DurationPicker:
//       // Date and Durationpicker background
//       dialogBackgroundColor: darkColorScheme.cardColor,
//       // ColorPicker hex-textfield label
//       hintColor: darkColorScheme.onBackgroundSoft,
//       // DurationPicker innercircle color
//       canvasColor: darkColorScheme.cardColor,
//       // DurationPicker thick circle border
//       backgroundColor: darkColorScheme.tertiary);

  static ThemeData lightThemeData() {
    final ThemeData themeData = ThemeData().copyWith(
      scrollbarTheme: ScrollbarThemeData(
        isAlwaysShown: false,
        thickness: MaterialStateProperty.all(10),
        radius: const Radius.circular(10),
        minThumbLength: 50,
      ),
    );
// Must be declared explicitly to be passed on to the TextTheme, which relies
// on the colorScheme
    final ColorScheme lightColorScheme = ColorSchemes.darkColorScheme();
    final TextTheme lightTextTheme =
        TextThemes.defaultTextTheme(lightColorScheme);
    final ColorScheme darkColorScheme = ColorSchemes.darkColorScheme();
    final TextTheme darkTextTheme =
        TextThemes.defaultTextTheme(darkColorScheme);

    final ThemeData lightThemeData = themeData.copyWith(
        brightness: Brightness.light,
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
        backgroundColor: lightColorScheme.tertiary);

    final ThemeData darkThemeData = themeData.copyWith(
        brightness: Brightness.dark,
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
        backgroundColor: darkColorScheme.tertiary);
    return lightThemeData;
  }

  static ThemeData darkThemeData() {
    final ThemeData themeData = ThemeData().copyWith(
      scrollbarTheme: ScrollbarThemeData(
        isAlwaysShown: false,
        thickness: MaterialStateProperty.all(10),
        radius: const Radius.circular(10),
        minThumbLength: 50,
      ),
    );
// Must be declared explicitly to be passed on to the TextTheme, which relies
// on the colorScheme
    final ColorScheme lightColorScheme = ColorSchemes.darkColorScheme();
    final TextTheme lightTextTheme =
        TextThemes.defaultTextTheme(lightColorScheme);
    final ColorScheme darkColorScheme = ColorSchemes.darkColorScheme();
    final TextTheme darkTextTheme =
        TextThemes.defaultTextTheme(darkColorScheme);

    final ThemeData lightThemeData = themeData.copyWith(
        brightness: Brightness.light,
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
        backgroundColor: lightColorScheme.tertiary);

    final ThemeData darkThemeData = themeData.copyWith(
        brightness: Brightness.dark,
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
        backgroundColor: darkColorScheme.tertiary);
    return darkThemeData;
  }
}
