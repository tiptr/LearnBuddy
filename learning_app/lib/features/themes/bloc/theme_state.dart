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
}
