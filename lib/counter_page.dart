import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/state_managers/use_bloc_provider.dart';
import 'core/state_managers/counter_factory.dart';
import 'core/presentation/widgets/text_widget.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';
import 'features/counter/cubits/_counter/counter_cubit.dart';
import 'core/utils/show_dialog.dart';
import 'core/presentation/pages/other_page.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final useBloc =
        context.select<UseBlocProvider, bool>((provider) => provider.useBloc);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Counter Page', TextType.titleMedium),
      ),
      body: MultiBlocListener(
        listeners: [
          if (useBloc)
            BlocListener<CounterOnBloc, CounterOnBLoCState>(
              listener: (context, state) =>
                  _handleSideEffects(context, state.counter),
            ),
          if (!useBloc)
            BlocListener<CounterOnCubit, CounterOnCubitState>(
              listener: (context, state) =>
                  _handleSideEffects(context, state.counter),
            ),
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget('Поточне значення:', TextType.headline),
              _buildCounterDisplay(context, useBloc),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  // 🟢 Віджет для відображення лічильника
  Widget _buildCounterDisplay(BuildContext context, bool useBloc) {
    final counter = useBloc
        ? context.select<CounterOnBloc, int>((bloc) => bloc.state.counter)
        : context.select<CounterOnCubit, int>((cubit) => cubit.state.counter);

    return TextWidget('$counter', TextType.headline);
  }

  // 🟢 Кнопки для збільшення/зменшення лічильника
  Widget _buildFloatingActionButtons(BuildContext context) {
    final counterManager = CounterFactory().create(context);

    return Row(
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
    );
  }

  // 🟢 Обробка side-ефектів
  void _handleSideEffects(BuildContext context, int counter) {
    if (counter == 3) {
      DialogService.showAlertDialog(context, 'Counter is $counter');
    } else if (counter == -1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtherPage()),
      );
    }
  }
}
