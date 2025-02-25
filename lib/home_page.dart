import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/presentation/widgets/text_widget.dart';
import 'core/state_managers/use_bloc_provider.dart';
import 'counter_page.dart';
import 'features/counter/presentation/theme_page.dart';
import 'core/utils/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final useBloc = context.watch<UseBlocProvider>().useBloc;
    final toggleUseBloc = context.read<UseBlocProvider>().toggleUseBloc;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TextWidget(
            'Counter on ${useBloc ? 'BLoC' : 'Cubit'}',
            TextType.titleMedium,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
