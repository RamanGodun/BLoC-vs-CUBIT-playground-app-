import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* BLoC */
import '../../../core/presentation/pages/theme_page.dart';

import '../../../core/state_managing/state_switching_of_counter_which_depends_on_color/counter_depends_on_color_manager.dart';
import '../../../core/state_managing/state_switching_of_counter_which_depends_on_color/factory_for_counter_which_depends_on_color.dart';
import '../color_on_bloc/color_bloc.dart';

/* CUBIT */
import '../color_on_cubit/color_cubit.dart';

import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../counter_on_bloc/counter_bloc.dart';

class CounterDependsOnColorPage extends StatelessWidget {
  const CounterDependsOnColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterDependsOnColorFactory.create(context);

    return Scaffold(
      backgroundColor: counterManager is BlocCounterDependsOnColorManager
          ? context.watch<ColorOnBloc>().state.color // ! When using BLoC
          : context.watch<ColorCubit>().state.color, // ! When using CUBIT
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Helpers.pushTo(context, const ThemePage()),
              icon: const Icon(Icons.sunny))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: counterManager.changeColor,
              child: const TextWidget('Change Color', TextType.button),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<CounterBlocWhichDependsOnColorBLoC,
                CounterStateWhichDependsOnColorBloc>(
              builder: (context, state) {
                return TextWidget('${state.counter}', TextType.headline);
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => counterManager.changeCounter(),
              child: const TextWidget('Change Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}
