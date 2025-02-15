import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../cubits/color/color_cubit.dart';
import '../cubits/counter_with_color/counter_with_color_cubit.dart';
import 'theme_page.dart';

class CounterWithColorOnCubitPage extends StatelessWidget {
  const CounterWithColorOnCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Helpers.pushTo(context, const ThemePage()),
              icon: const Icon(Icons.sunny))
        ],
      ),
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<ColorCubit>().changeColor(),
              child: const TextWidget('Change Color', TextType.button),
            ),
            const SizedBox(height: 20.0),
            TextWidget(
              '${context.watch<CounterWithColorCubit>().state.counter}',
              TextType.headline,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () =>
                  context.read<CounterWithColorCubit>().changeCounter(),
              child: const TextWidget('Change Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}
