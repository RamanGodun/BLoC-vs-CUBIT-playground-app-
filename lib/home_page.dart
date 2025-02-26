import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/presentation/widgets/text_widget.dart';
import 'core/state_managers/app_state/app_state_cubit.dart';
import 'counter_page.dart';
import 'features/counter/presentation/theme_page.dart';
import 'core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateCubit>().state;

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
            onPressed: () => context.read<AppStateCubit>().toggleUseBloc(),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Helpers.pushTo(context, const CounterPage()),
          child: const TextWidget('Go to Counter Page', TextType.button),
        ),
      ),
    );
  }
}