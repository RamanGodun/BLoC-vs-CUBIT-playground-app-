import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/pages/other_page.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/show_dialog.dart';
import 'bloc/counter_bloc.dart';

class MyHomePage4BLoC extends StatelessWidget {
  const MyHomePage4BLoC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            DialogService.showAlertDialog(
                context, 'counter is ${state.counter}');
          } else if (state.counter == -1) {
            Helpers.pushTo(context, const OtherPage());
          }
        },
        child: ListView(
          children: [
            const SizedBox(height: 250),
            TextWidget(
              '${context.watch<CounterBloc>().state.counter}',
              TextType.headline,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context)
                  .add(IncrementCounterEvent());
            },
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
