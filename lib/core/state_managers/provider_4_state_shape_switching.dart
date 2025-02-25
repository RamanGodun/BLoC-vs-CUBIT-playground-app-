import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider4StateShapeSwitching extends ChangeNotifier {
  bool _useBloc = true;
  ThemeMode _themeMode = ThemeMode.light;

  bool get useBloc => _useBloc;
  ThemeMode get themeMode => _themeMode;

  Provider4StateShapeSwitching() {
    _loadThemeMode();
  }

  void toggleUseBloc() {
    _useBloc = !_useBloc;
    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = (prefs.getBool('isDarkMode') ?? false)
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }
}
