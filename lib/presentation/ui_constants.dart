import 'package:flutter/material.dart';

/// 🎨 Enum representing available app themes.
enum AppTheme { light, dark }

/// 🌈 [UIConstants] holds the application's static UI-related constants and theme configurations.
abstract class UIConstants {
  static final lightTheme = ThemeData.light(useMaterial3: true);
  static final darkTheme = ThemeData.dark(useMaterial3: true);
  static const errorColor = Colors.red;
}
