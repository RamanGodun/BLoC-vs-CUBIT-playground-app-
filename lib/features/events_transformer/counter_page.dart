import 'package:bloc_by_korean/presentation/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';

class CounterWithEventTransformerHandling extends StatelessWidget {
  const CounterWithEventTransformerHandling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Transformers Demo")),
      body: Center(
        child: TextWidget(
          '${context.watch<CounterBlocWithTransformers>().state.counter}',
          TextType.headline,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment_btn',
            onPressed: () => context
                .read<CounterBlocWithTransformers>()
                .add(IncrementCounterEvent()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'decrement_btn',
            onPressed: () => context
                .read<CounterBlocWithTransformers>()
                .add(DecrementCounterEvent()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
