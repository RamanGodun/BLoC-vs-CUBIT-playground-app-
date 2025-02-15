import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../cubits/theme/theme_cubit.dart';
// import '../_theme_bloc/theme_bloc.dart';

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
            final int randInt = Random().nextInt(10);
            print('randInt: $randInt');
            context.read<ThemeCubit>().changeTheme(randInt);
            // context.read<ThemeBloc>().add(ChangeThemeEvent(randInt: randInt)); // when use BLoc
          },
          child: const TextWidget('Change Theme', TextType.button),
        ),
      ),
    );
  }
}
