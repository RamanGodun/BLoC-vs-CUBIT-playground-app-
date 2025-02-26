import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider4StateShapeSwitching extends ChangeNotifier {
  final SharedPreferences prefs;

  bool _useBloc = true;
  ThemeMode _themeMode = ThemeMode.light;

  Provider4StateShapeSwitching({required this.prefs}) {
    _loadPreferences();
  }

  bool get useBloc => _useBloc;
  ThemeMode get themeMode => _themeMode;

  // 🟢 Завантаження налаштувань
  void _loadPreferences() {
    _useBloc = prefs.getBool('useBloc') ?? true;
    _loadThemeForCurrentManager();
    notifyListeners();
  }

  // 🟢 Завантаження теми для поточного менеджера
  void _loadThemeForCurrentManager() {
    if (_useBloc) {
      _themeMode = (prefs.getBool('isDarkModeBloc') ?? false)
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      _themeMode = (prefs.getBool('isDarkModeCubit') ?? false)
          ? ThemeMode.dark
          : ThemeMode.light;
    }
  }

  // 🟢 Перемикання між BLoC та Cubit
  void toggleUseBloc() {
    _saveThemeMode(); // Зберігаємо поточний стан теми для поточного менеджера
    _useBloc = !_useBloc;
    _loadThemeForCurrentManager(); // Завантажуємо тему для нового менеджера
    _saveUseBloc();
    notifyListeners();
  }

  // 🟢 Перемикання теми
  void toggleThemeMode(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  // 🟢 Збереження стану useBloc
  Future<void> _saveUseBloc() async {
    await prefs.setBool('useBloc', _useBloc);
  }

  // 🟢 Збереження теми для відповідного менеджера
  Future<void> _saveThemeMode() async {
    if (_useBloc) {
      await prefs.setBool('isDarkModeBloc', _themeMode == ThemeMode.dark);
    } else {
      await prefs.setBool('isDarkModeCubit', _themeMode == ThemeMode.dark);
    }
  }
}
