import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../core/state_managing/theme/theme_bloc.dart';
import 'counter/counter_bloc.dart';

class CounterOnHydratedBlocPage extends StatelessWidget {
  const CounterOnHydratedBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FloatingActionButton(
            onPressed: () {
              context.read<HydratedThemeBloc>().add(ToggleThemeEvent());
            },
            child: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Center(
        child: Text(
          '${context.watch<HydratedCounterBloc>().state.counter}',
          style: const TextStyle(fontSize: 64.0),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<HydratedCounterBloc>().add(IncrementCounterEvent());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            onPressed: () {
              context.read<HydratedCounterBloc>().add(DecrementCounterEvent());
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            onPressed: () {
              HydratedBloc.storage.clear();
            },
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
