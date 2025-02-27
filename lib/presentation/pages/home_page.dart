import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/counter_depends_on_color/presentation/counter_depends_on_color_page.dart';
import '../widgets/text_widget.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart'; //! When use BLOC a state-shape handler
// import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart'; // !when use CUBIT a state-shape handler
import '../../features/counter/presentation/counter_page.dart';
import 'theme_page.dart';
import '../../core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .watch<AppSettingsOnBloc>()
        .state; //! When using BLOC as a state-shape handler
    // final state =
    //     context.watch<AppSettingsOnCubit>().state; // ! When using CUBIT as a state-shape handler

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextWidget(
            'App is on ${state.isUseBloc ? 'BLoC' : 'Cubit'} now',
            TextType.titleMedium,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(state.isUseBloc
                ? (state.isDarkThemeForBloc
                    ? Icons.dark_mode
                    : Icons.light_mode)
                : (state.isDarkThemeForCubit
                    ? Icons.dark_mode
                    : Icons.light_mode)),
            onPressed: () => Helpers.pushTo(context, const ThemePage()),
          ),
          IconButton(
            icon: Icon(state.isUseBloc ? Icons.sync : Icons.change_circle),
// ! When using CUBIT as a state-shape handler
            // onPressed: () => context
            //     .read<AppSettingsOnCubit>()
            //     .toggleUseBloc(),
//! When using BLOC as a state-shape handler
            onPressed: () =>
                context.read<AppSettingsOnBloc>().add(ToggleUseBlocEvent()),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Helpers.pushTo(context, const CounterPage()),
              child: const TextWidget('Go to Counter Page', TextType.button),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () =>
                  Helpers.pushTo(context, const CounterDependsOnColorPage()),
              child: const TextWidget(
                  'Go to CounterDependsOnColor page', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}
