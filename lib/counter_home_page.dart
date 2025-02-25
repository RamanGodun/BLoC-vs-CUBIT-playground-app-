import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/pages/other_page.dart';
import 'core/presentation/widgets/text_widget.dart';
import 'core/state_managers/counter_manager.dart';
import 'core/utils/helpers.dart';
import 'core/utils/show_dialog.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';
import 'features/counter/cubits/_counter/counter_cubit.dart';
import 'features/counter/presentation/theme_page.dart';
import 'core/state_managers/counter_factory.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool useBloc = true;

  // 🟢============= Build Method ===============🟢 //

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterFactory.create(context, useBloc: useBloc);

    return useBloc
        ? BlocListener<CounterOnBloc, CounterOnBLoCState>(
            listener: (context, state) =>
                _sideActionsThatDependsOnCounterState(context, state.counter),
            child: _buildScaffoldWithBlocBuilder(counterManager),
          )
        : BlocListener<CounterOnCubit, CounterOnCubitState>(
            listener: (context, state) =>
                _sideActionsThatDependsOnCounterState(context, state.counter),
            child: _buildScaffoldWithBlocBuilder(counterManager),
          );
  }

  Widget _buildScaffoldWithBlocBuilder(CounterManager counterManager) {
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
            onPressed: _toggleStateManager,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget('Поточне значення:', TextType.headline),
            _buildCounterDisplay(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: counterManager.increment,
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: counterManager.decrement,
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  // 🟢============= Used METHODS ===============🟢 //

  Widget _buildCounterDisplay() {
    return useBloc
        ? BlocBuilder<CounterOnBloc, CounterOnBLoCState>(
            builder: (context, state) =>
                TextWidget('${state.counter}', TextType.headline),
          )
        : BlocBuilder<CounterOnCubit, CounterOnCubitState>(
            builder: (context, state) =>
                TextWidget('${state.counter}', TextType.headline),
          );
  }

  void _toggleStateManager() => setState(() => useBloc = !useBloc);

  void _sideActionsThatDependsOnCounterState(
      BuildContext context, int counter) {
    if (counter == 3) {
      DialogService.showAlertDialog(context, 'Counter is $counter');
    } else if (counter == -1) {
      Helpers.pushTo(context, const OtherPage());
    }
  }

  // 🟢=============  ===============🟢 //
}
