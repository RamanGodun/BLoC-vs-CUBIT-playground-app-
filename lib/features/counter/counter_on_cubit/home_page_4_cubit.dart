import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/show_dialog.dart';
import 'cubit/counter_cubit.dart';
import '../../../core/presentation/pages/other_page.dart';

class MyHomePage4Cubit extends StatelessWidget {
  const MyHomePage4Cubit({super.key});

/*
===========================================
✅ ОСНОВНИЙ ВАРІАНТ (СТАНДАРТНИЙ)
- Використовує `BlocListener` для прослуховування подій
- Використовує `context.select()` для оновлення лише `counter`
===========================================
*/
  @override
  Widget build(BuildContext context) {
    final readCounterCubit = context.read<CounterCubit>();
    final selectCounterCubit =
        context.select<CounterCubit, int>((cubit) => cubit.state.counter);

    return MultiBlocListener(
      listeners: [
        BlocListener<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.counter == 3) {
              DialogService.showAlertDialog(
                  context, 'counter is ${state.counter}');
            } else if (state.counter == -1) {
              Helpers.pushTo(context, const OtherPage());
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              const SizedBox(height: 250),
              const TextWidget('Поточне значення:', TextType.headline),
              TextWidget(
                /*
                📝 `selectCounterCubit` оновлює UI тільки при зміні `counter`
                */
                selectCounterCubit.toString(),
                TextType.headline,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => readCounterCubit.increment(),
              heroTag: 'increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 10.0),
            FloatingActionButton(
              onPressed: () => readCounterCubit.decrement(),
              heroTag: 'decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }

/*
===========================================
✅ АЛЬТЕРНАТИВНІ ПІДХОДИ
===========================================
*/

/*
===========================================
🟢 1. ВИКОРИСТАННЯ `BlocConsumer`
- Поєднує `BlocListener` + `BlocBuilder`
- UI оновлюється при будь-яких змінах `state`
===========================================

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            DialogService.showAlertDialog(
                context, 'counter is ${state.counter}');
          } else if (state.counter == -1) {
            Helpers.pushTo(context, const OtherPage());
          }
        },
        builder: (context, state) => Center(
          child: ListView(
            children: [
              const SizedBox(height: 250),
              const TextWidget('Поточне значення:', TextType.headline),
              TextWidget(
                '${state.counter}',
                TextType.headline,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

*/

/*
===========================================
🟢 2. ВИКОРИСТАННЯ `Builder` + `context.select()`
- Оновлює ТІЛЬКИ `counter`, не весь `state`
- Не перевикликає `build()`
===========================================

 @override
  Widget build(BuildContext context) {
    final readCounterCubit = context.read<CounterCubit>();

    return BlocListener<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.counter == 3) {
          DialogService.showAlertDialog(context, 'counter is ${state.counter}');
        } else if (state.counter == -1) {
          Helpers.pushTo(context, const OtherPage());
        }
      },
      child: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              final counter = context
                  .select<CounterCubit, int>((cubit) => cubit.state.counter);
              return ListView(
                children: [
                  TextWidget('$counter', TextType.headline),
                ],
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => readCounterCubit.increment(),
              heroTag: 'increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 10.0),
            FloatingActionButton(
              onPressed: () => readCounterCubit.decrement(),
              heroTag: 'decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
*/
}
