import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/state_managers/provider_4_state_shape_switching.dart';
import '../cubits/_theme/theme_cubit.dart';
import '../blocs/_theme_bloc/theme_bloc.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final useBloc = context.watch<Provider4StateShapeSwitching>().useBloc;

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Theme screen', TextType.titleMedium),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final isDarkMode = Random().nextBool();

            if (useBloc) {
              context
                  .read<ThemeOnBloc>()
                  .add(ChangeThemeEvent(isDarkMode: isDarkMode));
            } else {
              context.read<ThemeCubit>().toggleTheme(isDarkMode);
            }

            // 🟢 Оновлення теми у провайдері
            context
                .read<Provider4StateShapeSwitching>()
                .toggleThemeMode(isDarkMode);
          },
          child: const TextWidget('Toggle Theme', TextType.button),
        ),
      ),
    );
  }
}
