import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isDark;
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
  }
//Switching themes in the flutter apps - Flutterant
  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
