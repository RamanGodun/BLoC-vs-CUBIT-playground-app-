import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart'; // ! When use CUBIT
// import '../../state_managing/app_settings_on_bloc/app_settings_bloc.dart'; // ! When use BLOC
import '../widgets/text_widget.dart';

// import '../../../core/state_managers/app_state_on_cubit/cubit.dart';

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
            context
                .read<AppSettingsOnCubit>()
                .toggleTheme(isDarkMode); // ! When use CUBIT
            // context.read<AppSettingsOnBloc>().add(
            //     ToggleThemeEvent(isDarkMode: isDarkMode)); // ! When use BLOC
          },
          child: const TextWidget('Toggle Theme', TextType.button),
        ),
      ),
    );
  }
}
