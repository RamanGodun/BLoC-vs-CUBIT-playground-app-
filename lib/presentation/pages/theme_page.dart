import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/config/app_config.dart';
import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import '../widgets/text_widget.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Theme screen', TextType.titleMedium),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final isDarkMode = Random().nextBool();
            AppConfig.isUsingBlocStateShape
                ? context
                    .read<AppSettingsOnBloc>()
                    .add(ToggleThemeEvent(isDarkMode: isDarkMode))
                : context.read<AppSettingsOnCubit>().toggleTheme(isDarkMode);
          },
          child: const TextWidget('Toggle Theme', TextType.button),
        ),
      ),
    );
  }
}
