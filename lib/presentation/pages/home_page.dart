import 'package:bloc_by_korean/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/route_names.dart';
import '../widgets/text_widget.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart'; //! When use BLOC a state-shape handler
import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart'; // !when use CUBIT a state-shape handler
import '../../core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        'Using ${AppConfig.isUsingBlocStateShape ? 'BLoC' : 'Cubit'} for theme toggle');
    final state = AppConfig.isUsingBlocStateShape
        ? context.watch<AppSettingsOnBloc>().state
        : context.watch<AppSettingsOnCubit>().state;

    final isUseBloc = (state as dynamic).isUseBloc;
    final isDarkMode = isUseBloc
        ? (state as dynamic).isDarkThemeForBloc
        : (state as dynamic).isDarkThemeForCubit;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextWidget(
            'App is on ${isUseBloc ? 'BLoC' : 'Cubit'} now',
            TextType.titleMedium,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isUseBloc
                ? (isDarkMode ? Icons.dark_mode : Icons.light_mode)
                : (isDarkMode ? Icons.dark_mode : Icons.light_mode)),
            onPressed: () => Helpers.pushNamed(context, RouteNames.themePage),
          ),
          IconButton(
            icon: Icon(isUseBloc ? Icons.sync : Icons.change_circle),
            onPressed: () => AppConfig.isUsingBlocStateShape
                ? context.read<AppSettingsOnBloc>().add(ToggleUseBlocEvent())
                : context.read<AppSettingsOnCubit>().toggleUseBloc(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Helpers.pushNamed(context, RouteNames.counterPage),
              child: const TextWidget('Go to Counter Page', TextType.button),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () => Helpers.pushNamed(
                    context, RouteNames.counterDependsOnColor),
                child: const TextWidget(
                    'Go to CounterDependsOnColor page', TextType.button)),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () =>
                  Helpers.pushNamed(context, RouteNames.blocAccess),
              child: const TextWidget('Show Me Counter', TextType.button),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Helpers.pushNamed(
                  context, RouteNames.counterEventTransformerDemo),
              child:
                  const TextWidget('Event Transformers Demo', TextType.button),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () =>
                  Helpers.pushNamed(context, RouteNames.counterHydrated),
              child: const TextWidget('Hydrated BLoC Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}
