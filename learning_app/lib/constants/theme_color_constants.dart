import 'package:flutter/material.dart';

/// Contains multiple instances of usable [ColorScheme] objects.
/// The class [ColorScheme] does not contain all attributes used in the code,
/// and therefore, the other values are declared in the extension
/// [CustomColorScheme] down below.
class ColorSchemes {
  /// Feature Relase: dark mode
  static ColorScheme darkColorScheme() {
    const backgroundColor = Color(0xFF212121);
    const onBackgroundColor = Color(0xFFAAAAAA);
    const onBackgroundHardColor = Color(0xFFFFFFFF);
    ColorScheme darkTheme = const ColorScheme.dark().copyWith(
      primary: const Color(0xFFFF2222),
      secondary: const Color(0xFFEEEE44),
      background: backgroundColor,
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF000000),
      onBackground: onBackgroundColor,

      //necessary for native components such as DatePicker, DurationPicker
      surface: backgroundColor,
      onSurface: onBackgroundHardColor,
    );
    darkTheme.setCustomAttributes(
      greyOutOverlayColor: const Color(0xB8060606),
      noCategoryDefaultColor: darkTheme.onBackground,
      onBackgroundHard: onBackgroundHardColor,
      onBackgroundSoft: const Color(0xFF636573),
      tertiary: const Color(0xFFFF8844),
      onTertiary: const Color(0xFF000000), // Same as onBackgroundHard
      subtleBackgroundGrey: const Color(0xFF3F3F3F),
      cardColor: const Color(0xFF303030),
      shadowColor: const Color(0xFF000000),
      isDark: true,
    );
    return darkTheme;
  }

  /// Returns the default theme
  static ColorScheme defaultColorScheme() {
    const backgroundColor = Color(0xFFF9F9FE);
    const onBackgroundColor = Color(0xFF636573);
    ColorScheme theme = ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF3444CF),
          secondary: const Color(0xFF9E5EE1),
          background: backgroundColor,
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          onBackground: onBackgroundColor,

          //necessary for native components such as DatePicker, DurationPicker
          surface: backgroundColor,
          onSurface: onBackgroundColor,
        );
    theme.setCustomAttributes(
      greyOutOverlayColor: const Color(0xB8FFFFFF),
      noCategoryDefaultColor: theme.onBackground,
      onBackgroundHard: const Color(0xFF40424A),
      onBackgroundSoft: const Color(0xFF949597),
      tertiary: const Color(0xFF39BBD1),
      onTertiary: const Color(0xFF40424A), // Same as onBackgroundHard
      subtleBackgroundGrey: const Color(0xFFCBCCCD),
      cardColor: const Color(0xFFFFFFFF),
      shadowColor: const Color(0xFF000000).withOpacity(0.8),
      isDark: false,
    );
    return theme;
  }
}

/// Extends the [ColorScheme} class with all necessary attributes, that are not
/// originally in the [ColorScheme] class. The attributes can be null. In that
/// case, defaults are returned in the getters.
extension CustomColorScheme on ColorScheme {
  // A color for debugging when creating a new ColorScheme to see which custom
  // color attributes were NOT set.
  static const Color _customAttributeForgotToSetColor = Colors.red;

  static Color? _greyOutOverlayColor;
  static Color? _noCategoryDefaultColor;
  static Color? _cardColor;

  static Color? _tertiary;
  static Color? _onTertiary;
  // Mockup greys
  static Color? _onBackgroundHard;
  static Color? _onBackgroundSoft;

  // Circle Progress Indicator Grey Color
  static Color? _subtleBackgroundGrey;

  static Color? _shadowColor;

  static late bool _isDark;

  /// Sets the custom attributes that are not contained in the ColorScheme class
  setCustomAttributes({
    Color? greyOutOverlayColor,
    Color? noCategoryDefaultColor,
    Color? tertiary,
    Color? onTertiary,
    Color? onBackgroundHard,
    Color? onBackgroundSoft,
    Color? subtleBackgroundGrey,
    Color? cardColor,
    Color? shadowColor,
    required isDark,
  }) {
    //Using ??= to allow multiple calls of this method, without overriding set values
    _greyOutOverlayColor ??= greyOutOverlayColor;
    _noCategoryDefaultColor ??= noCategoryDefaultColor;

    _tertiary ??= tertiary;
    _onTertiary ??= onTertiary;

    _onBackgroundHard ??= onBackgroundHard;
    _onBackgroundSoft ??= onBackgroundSoft;
    _subtleBackgroundGrey ??= subtleBackgroundGrey;
    _cardColor ??= cardColor;
    _shadowColor ??= shadowColor;
    _isDark = isDark;
  }

  // Getters of all attributes with defaults if not set. Default red, to clearly
  // see which color was not set.
  Color get greyOutOverlayColor =>
      _greyOutOverlayColor ?? _customAttributeForgotToSetColor;
  Color get noCategoryDefaultColor =>
      _noCategoryDefaultColor ?? _customAttributeForgotToSetColor;
  Color get cardColor => _cardColor ?? _customAttributeForgotToSetColor;

  Color get tertiary => _tertiary ?? _customAttributeForgotToSetColor;
  Color get onTertiary => _onTertiary ?? _customAttributeForgotToSetColor;

  Color get onBackgroundHard =>
      _onBackgroundHard ?? _customAttributeForgotToSetColor;
  Color get onBackgroundSoft =>
      _onBackgroundSoft ?? _customAttributeForgotToSetColor;

  Color get subtleBackgroundGrey =>
      _subtleBackgroundGrey ?? _customAttributeForgotToSetColor;

  Color get shadowColor => _shadowColor ?? _customAttributeForgotToSetColor;

  bool get isDark => _isDark;
}
