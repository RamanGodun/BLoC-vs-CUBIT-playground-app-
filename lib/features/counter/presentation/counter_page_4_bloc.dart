import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/pages/other_page.dart';
import '../../../core/presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/show_dialog.dart';
import 'theme_page.dart';
import '../blocs/_counter_bloc/counter_bloc.dart';

class MyHomePage4BLoC extends StatelessWidget {
  const MyHomePage4BLoC({super.key});

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
      /*
      🟢 BlocListener використовується для відстеження змін стану та виклику побічних ефектів (side effects).
      - Тут він реагує на зміни у `CounterBloc`.
      - НЕ впливає на UI напряму, лише запускає певні дії, такі як показ діалогового вікна або навігацію.
      */
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            // Якщо `counter` дорівнює 3, показуємо діалогове вікно
            DialogService.showAlertDialog(
                context, 'counter is ${state.counter}');
          } else if (state.counter == -1) {
            // Якщо `counter` дорівнює -1, переходимо на іншу сторінку
            Helpers.pushTo(context, const OtherPage());
          }
        },
        child: ListView(
          children: [
            const SizedBox(height: 250),
            const TextWidget('Поточне значення:', TextType.headline),

            /*
            🟢 Використання `context.watch<CounterBloc>()`
            - `watch` означає, що цей віджет буде оновлюватися при кожній зміні стану `CounterBloc`.
            - Кожного разу, коли `CounterState.counter` змінюється, цей віджет перерисовується.
            - Якщо потрібно слідкувати лише за зміною `counter`, краще використовувати `context.select()`.
            */
            TextWidget(
              '${context.watch<CounterBloc>().state.counter}',
              TextType.headline,
            ),
          ],
        ),
      ),

      /*
      🟢 Кнопки для збільшення та зменшення значення `counter`
      - Використовують `BlocProvider.of<CounterBloc>(context)` та `context.read<CounterBloc>()`
      - Відправляють події `IncrementCounterEvent` та `DecrementCounterEvent`
      */
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              /*
              🟢 Додавання події до BLoC через `BlocProvider.of<CounterBloc>(context).add()`
              - Цей варіант працює аналогічно `context.read<CounterBloc>().add()`
              - Використовується для відправки події `IncrementCounterEvent`
              - `Bloc` отримає цю подію і оновить стан
              */
              BlocProvider.of<CounterBloc>(context)
                  .add(IncrementCounterEvent());
            },
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              /*
              🟢 Альтернативний спосіб додавання події до BLoC:
              - Використання `context.read<CounterBloc>().add()`
              - Виконує ту ж функцію, що й `BlocProvider.of<CounterBloc>(context).add()`, але запис виглядає чистіше.
              */
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
