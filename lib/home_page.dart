import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/presentation/widgets/text_widget.dart';
import 'core/state_managers/provider_4_state_shape_switching.dart';
import 'counter_page.dart';
import 'features/counter/presentation/theme_page.dart';
import 'core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final useBloc = context.watch<Provider4StateShapeSwitching>().useBloc;
    final toggleUseBloc =
        context.read<Provider4StateShapeSwitching>().toggleUseBloc;
    final themeMode = context.watch<Provider4StateShapeSwitching>().themeMode;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextWidget(
            'App is on ${useBloc ? 'BLoC' : 'Cubit'} now',
            TextType.titleMedium,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => Helpers.pushTo(context, const ThemePage()),
          ),
          IconButton(
            icon: Icon(useBloc ? Icons.sync : Icons.change_circle),
            onPressed: toggleUseBloc,
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
