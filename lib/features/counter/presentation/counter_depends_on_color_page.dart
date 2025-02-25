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
import '../blocs/counter_which_depends_on_color/counter_bloc.dart';
import '../blocs/color/color_bloc.dart';

/*
Presentation
 */
import 'theme_page.dart';
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
      backgroundColor: context.watch<ColorOnBloc>().state.color, //when use BLoC
      // backgroundColor: context.watch<ColorCubit>().state.color, //when use CUBIT
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed:
//  Next, when use BLoC

                  () => Helpers.pushTo(
                      context, const ThemePage()), //when use CUBIT
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
                  () => context.read<ColorOnBloc>().add(ChangeColorEvent()),
              // () => context.read<ColorCubit>().changeColor(), // this, when use CUBIT
              child: const TextWidget('Change Color', TextType.button),
            ),
            const SizedBox(height: 20.0),
            TextWidget(
              /*
            🟢 Використання `context.watch<CounterBloc>()`
            - `watch` означає, що цей віджет буде оновлюватися при кожній зміні стану `CounterBloc`.
            - Кожного разу, коли `CounterState.counter` змінюється, цей віджет перерисовується.
            - Якщо потрібно слідкувати лише за зміною `counter`, краще використовувати `context.select()`.
            */
              '${context.watch<CounterBlocWhichDependsOnColorBLoC>().state.counter}',
              // '${context.watch<CounterCubitWhichDependsOnColorCubit>().state.counter}',
              TextType.headline,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () =>
                  // next when use BLoC
                  context
                      .read<CounterBlocWhichDependsOnColorBLoC>()
                      .add(ChangeCounterEvent()),
              // Next, when use CUBIT
              // context
              //                   .read<CounterCubitWhichDependsOnColorCubit>()
              //                   .changeCounter(),
              child: const TextWidget('Change Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}

/*
------------------------------------------------------------
NEXT when don't use BLocListener
!I don't like this alternative, because in such case UI and business logic are crosses in presentation layer 
------------------------------------------------------------

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
 */
