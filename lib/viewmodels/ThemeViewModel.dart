import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode _tempThemeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  ThemeMode get tempThemeMode => _tempThemeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void selectTheme(ThemeMode mode) {
    _tempThemeMode = mode;
    notifyListeners();
  }

  void applyTheme() {
    _themeMode = _tempThemeMode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _tempThemeMode = _themeMode;
    notifyListeners();
  }
}
