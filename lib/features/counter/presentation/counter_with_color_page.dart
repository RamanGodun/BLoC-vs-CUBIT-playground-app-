import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../cubits/color/color_cubit.dart';
import '../cubits/counter_with_color/counter_with_color_cubit.dart';
import 'theme_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../cubits/color/color_cubit.dart';
import '../cubits/counter_with_color/counter_with_color_cubit.dart';
import 'theme_page.dart';

/*
NEXT when don't use BLocListener
!BUT I prefer don't use BLocListener, because in such case UI and business logic are crosses 
 */
class CounterWithColorOnCubitPage extends StatefulWidget {
  const CounterWithColorOnCubitPage({super.key});

  @override
  State<CounterWithColorOnCubitPage> createState() =>
      _CounterWithColorOnCubitPageState();
}

class _CounterWithColorOnCubitPageState
    extends State<CounterWithColorOnCubitPage> {
  int incrementSize = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ColorCubit, ColorState>(
      listener: (context, state) {
        if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) {
          incrementSize = 10;
        } else if (state.color == Colors.blue) {
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          context.read<CounterWithColorCubit>().changeCounter(-100);
          incrementSize = -100;
        }
      },
      child: Scaffold(
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
                onPressed: () => context
                    .read<CounterWithColorCubit>()
                    .changeCounter(incrementSize),
                child: const TextWidget('Change Counter', TextType.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*
NEXT when don't use BLocListener
! I prefer this alternative way

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



 */