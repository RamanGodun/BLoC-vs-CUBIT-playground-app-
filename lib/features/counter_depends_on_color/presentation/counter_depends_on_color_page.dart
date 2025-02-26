import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/helpers.dart';
/*
CUBITs
 */
// import '../cubits/color/color_cubit.dart';
// import '../cubits/counter_which_depends_on_color/counter_which_depends_on_color_cubit.dart';

/*
BLoCs
 */
import '../counter_on_bloc/counter_bloc.dart';
import '../color_on_bloc/color_bloc.dart';

/*
Presentation
 */
import '../../../core/presentation/pages/theme_page.dart';
import '../../../core/presentation/widgets/text_widget.dart';

/*
------------------------------------------------------------
NEXT when don't use BLocListener
! I prefer this alternative way
------------------------------------------------------------
 */
class CounterDependsOnColorPage extends StatelessWidget {
  const CounterDependsOnColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ColorOnBloc>().state.color, // ! when using BLoC
      // backgroundColor: context.watch<ColorCubit>().state.color, // ! when using CUBIT
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
              onPressed:
                  // next, when use BLoC
                  () => context
                      .read<ColorOnBloc>()
                      .add(ChangeColorEvent()), // ! when using BLoC
              // () => context.read<ColorCubit>().changeColor(), // ! when using CUBIT
              child: const TextWidget('Change Color', TextType.button),
            ),
            const SizedBox(height: 20.0),
            TextWidget(
              '${context.watch<CounterBlocWhichDependsOnColorBLoC>().state.counter}', // ! when using BLoC
              // '${context.watch<CounterCubitWhichDependsOnColorCubit>().state.counter}', // ! when using CUBIT
              // 🟢 Якщо потрібно слідкувати лише за зміною `counter`, краще використовувати `context.select()
              TextType.headline,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context
                  .read<CounterBlocWhichDependsOnColorBLoC>()
                  .add(ChangeCounterEvent()), // ! when using BLoC
              // context
              //                   .read<CounterCubitWhichDependsOnColorCubit>()
              //                   .changeCounter(), // ! when using CUBIT
              child: const TextWidget('Change Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}
