import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'hydrated_counter_bloc/counter_bloc.dart';

class CounterOnHydratedBlocPage extends StatelessWidget {
  const CounterOnHydratedBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            heroTag: 'increment',
            onPressed: () {
              context.read<HydratedCounterBloc>().add(IncrementCounterEvent());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => context
                .read<HydratedCounterBloc>()
                .add(DecrementCounterEvent()),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            heroTag: 'clear',
            onPressed: () => HydratedBloc.storage.clear(),
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
