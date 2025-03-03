import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/config/app_config.dart';
import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import '../text_widget.dart';

/// 🌓 [ThemePage] allows toggling between light and dark themes randomly.
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Theme Screen', TextType.titleMedium),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _toggleTheme(context),
          child: const TextWidget('Toggle Theme', TextType.button),
        ),
      ),
    );
  }

  /// 🕹️ Randomly toggles the theme between light and dark.
  void _toggleTheme(BuildContext context) {
    final isDarkMode = Random().nextBool();
    if (AppConfig.isUsingBlocStateShape) {
      context
          .read<AppSettingsOnBloc>()
          .add(ToggleThemeEvent(isDarkMode: isDarkMode));
    } else {
      context.read<AppSettingsOnCubit>().toggleTheme(isDarkMode);
    }
    print('Theme toggled to ${isDarkMode ? 'Dark' : 'Light'} mode');
  }
}
