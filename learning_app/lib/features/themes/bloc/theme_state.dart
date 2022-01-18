import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../themes.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeName themeName;

  const ThemeState({
    required this.themeData,
    required this.themeName,
  }) : super();

  @override
  // TODO: implement props
  List<Object?> get props => [themeName];
}
