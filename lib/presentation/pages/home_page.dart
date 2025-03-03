import 'package:bloc_by_korean/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/route_names.dart';
import '../text_widget.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import '../../core/utils/helpers.dart';

/// 🏠 [HomePage] is the main entry point for navigating through the app features.
/// It dynamically switches between BLoC and Cubit state management based on [AppConfig].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔍 Determine if the app uses BLoC or Cubit for state management
    final state = AppConfig.isUsingBlocStateShape
        ? context.watch<AppSettingsOnBloc>().state
        : context.watch<AppSettingsOnCubit>().state;

    final isUseBloc = (state as dynamic).isUseBloc;
    final isDarkMode = isUseBloc
        ? (state as dynamic).isDarkThemeForBloc
        : (state as dynamic).isDarkThemeForCubit;

    print('🔄 Using ${isUseBloc ? 'BLoC' : 'Cubit'} for theme toggle');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextWidget(
            'App is on ${isUseBloc ? 'BLoC' : 'Cubit'} now',
            TextType.titleMedium,
          ),
        ),
        actions: [
          // 🌗 Theme toggle button
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => Helpers.pushNamed(context, RouteNames.themePage),
          ),
          // 🔄 Switch between BLoC and Cubit
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
            // 🚀 Navigation Buttons
            _buildNavigationButton(
              context,
              label: 'Go to Counter Page',
              routeName: RouteNames.counterPage,
            ),
            _buildNavigationButton(
              context,
              label: 'Go to CounterDependsOnColor page',
              routeName: RouteNames.counterDependsOnColor,
            ),
            _buildNavigationButton(
              context,
              label: 'Show Me Counter',
              routeName: RouteNames.blocAccess,
            ),
            _buildNavigationButton(
              context,
              label: 'Event Transformers Demo',
              routeName: RouteNames.counterEventTransformerDemo,
            ),
            _buildNavigationButton(
              context,
              label: 'Hydrated BLoC Counter',
              routeName: RouteNames.counterHydrated,
            ),
          ],
        ),
      ),
    );
  }

  /// 🧭 Helper method to build navigation buttons
  Widget _buildNavigationButton(BuildContext context,
      {required String label, required String routeName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: ElevatedButton(
        onPressed: () => Helpers.pushNamed(context, routeName),
        child: TextWidget(label, TextType.button),
      ),
    );
  }
}
