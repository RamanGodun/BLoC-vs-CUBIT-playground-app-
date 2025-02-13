import 'package:flutter/material.dart';

abstract class UIConstants {
  //
  static const Color errorColor = Colors.red;
  //
  static final appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
//
}

enum AppTheme {
  light,
  dark,
}
