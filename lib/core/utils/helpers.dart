import 'package:flutter/material.dart';

class Helpers {
  //
  static Future<void> pushTo(BuildContext context, Widget child) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => child),
    );
  }
  //

/*
  static void goTo(
    BuildContext context,
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    return context.goNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }
 */

  // static void goTo(
  //   BuildContext context,
  //   String routeName, {
  //   Map<String, String> pathParameters = const <String, String>{},
  //   Map<String, dynamic> queryParameters = const <String, dynamic>{},
  // }) {
  //   try {
  //     GoRouter.of(context).goNamed(
  //       routeName,
  //       pathParameters: pathParameters,
  //       queryParameters: queryParameters,
  //     );
  //   } catch (e) {
  //     // Якщо маршрут не знайдено, перенаправляємо на сторінку помилки
  //     GoRouter.of(context).go('/unknown');
  //   }
  // }

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

  /* For TIMER
   */
  static String zeroPaddedTwoDigits(double ticks) {
    return ticks.floor().toString().padLeft(2, '0');
  }

  static String formatTimer(int ticks) {
    final minutes = zeroPaddedTwoDigits((ticks / 60) % 60);
    final seconds = zeroPaddedTwoDigits(ticks % 60);
    return '$minutes:$seconds';
  }
}
