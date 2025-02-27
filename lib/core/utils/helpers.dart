import 'package:flutter/material.dart';

class Helpers {
  //
  static Future<void> pushTo(BuildContext context, Widget child) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => child),
    );
  }

  static void pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
  //

  static ThemeData getTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme;
  }

  static TextTheme getTextTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return textTheme;
  }

  static ColorScheme getColorScheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return colorScheme;
  }
}
