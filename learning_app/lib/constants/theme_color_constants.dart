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
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          onBackground: const Color(0xFF636573),
        );
    theme.setCustomAttributes(
      greyOutOverlayColor: const Color(0xB8FFFFFF),
      noCategoryDefaultColor: theme.onBackground,
      onBackgroundHard: const Color(0xFF40424A),
      onBackgroundSoft: const Color(0xFF949597),
      tertiary: const Color(0xFF39BBD1),
      onTertiary: const Color(0xFF40424A), // Same as onBackgroundHard
      subtleBackgroundGrey: const Color(0xFFEAECFA),
      cardColor: const Color(0xFFFFFFFF),
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
}
