import 'package:flutter/material.dart';

enum AppTheme { light, dark }

abstract class UIConstants {
  static final appTheme = ThemeData.light(useMaterial3: true);
  static final darkTheme = ThemeData.dark(useMaterial3: true);
  static const errorColor = Colors.red;
}
