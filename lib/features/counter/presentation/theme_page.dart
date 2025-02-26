import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/state_managers/app_state/app_state_cubit.dart';

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
            context.read<AppStateCubit>().toggleTheme(isDarkMode);
          },
          child: const TextWidget('Toggle Theme', TextType.button),
        ),
      ),
    );
  }
}