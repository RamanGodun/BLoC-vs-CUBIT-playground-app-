import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/route_names.dart';
import '../widgets/text_widget.dart';
import '../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart'; //! When use BLOC a state-shape handler
// import '../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart'; // !when use CUBIT a state-shape handler
import '../../core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
//! When using BLOC as a state-shape handler
    final state = context.watch<AppSettingsOnBloc>().state;
// ! When using CUBIT as a state-shape handler
    // final state =
    //     context.watch<AppSettingsOnCubit>().state;

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
            onPressed: () => Helpers.pushNamed(context, RouteNames.themePage),
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
          ],
        ),
      ),
    );
  }
}
