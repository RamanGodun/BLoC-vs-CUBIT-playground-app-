/*
==========================================================
📌 1️⃣ Життєвий цикл та робота Cubit (Глибоке розуміння)
==========================================================

Як працює Cubit?
---------------------------------
Cubit – це спрощена версія BLoC, яка має **прямий метод emit()** для оновлення стану.  
Його життєвий цикл виглядає так:

1️⃣ **Ініціалізація**
   • `CubitProvider` або `Cubit()` створює екземпляр Cubit.
   • Викликається **конструктор**, в якому визначається `initialState`.

2️⃣ **Взаємодія з UI**
   • UI викликає метод (наприклад, `increment()`).
   • Метод обчислює **новий стан** та викликає `emit(newState)`.  

3️⃣ **Виконання emit()**
   • Cubit **викликає `onChange(Change<T>)`** перед оновленням стану.
   • `Change<T>` містить **поточний стан (`currentState`) та новий (`nextState`)**.
   • Якщо `currentState == nextState`, то `emit()` не відбувається.

4️⃣ **Оновлення UI**
   • `BlocBuilder` або `BlocListener` отримує оновлений стан та перерендерює UI.

5️⃣ **Закриття (close())**
   • Коли Cubit більше не використовується, викликається `close()`.
   • Потік `state.stream` закривається, пам'ять очищається.

📝 **Приклад**:
-----------------------------------------------------------
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  @override
  void onChange(Change<int> change) {
    print('onChange: $change');
    super.onChange(change);
  }

  @override
  Future<void> close() {
    print('Cubit закривається...');
    return super.close();
  }
}
-----------------------------------------------------------

==========================================================
**********************************************************
==========================================================

📌 2️⃣ Життєвий цикл та робота BLoC (Глибоке розуміння)
==========================================================

BLoC – це **реактивний підхід**, який використовує **події (Event) та потоки (Stream)**.

Як працює BLoC?
---------------------------------
1️⃣ **Ініціалізація**
   • Створюється через `BlocProvider` або `Bloc()`.
   • Викликається конструктор `super(initialState)`.

2️⃣ **Додавання події (add(event))**
   • UI викликає `bloc.add(MyEvent())`.
   • Спрацьовує `onEvent()`, що дозволяє логувати подію.

3️⃣ **Event Transformer (Обробка подій у потоці)**
   • `BLoC` за замовчуванням **послідовно** обробляє події.
   • Можна використати **RxDart** (`debounceTime`, `switchMap`) для **оптимізації**.

4️⃣ **Обробка Event Handler (`on<T>`)**
   • Відповідний `on<T>` виконує обчислення та викликає `emit(newState)`.
   • **BLoC може емітувати декілька станів поспіль**.

5️⃣ **Зміна стану (`emit(newState)`)**
   • Спрацьовує `onTransition()`, який містить `currentState → nextState`.

6️⃣ **Закриття (close())**
   • Потік `state.stream` закривається, підписки видаляються.
   • Викликається `onClose()` для очищення пам’яті.

📝 **Приклад**:
-----------------------------------------------------------
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) {
      emit(state + 1);
    });
  }

  @override
  void onEvent(CounterEvent event) {
    print('onEvent: $event');
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print('onTransition: $transition');
    super.onTransition(transition);
  }

  @override
  Future<void> close() {
    print('Bloc закривається...');
    return super.close();
  }
}
-----------------------------------------------------------


==========================================================
**********************************************************
==========================================================


📌 Патерни взаємодії BLoC
==========================================================

BLoC, що залежить від іншого BLoC (Stream Subscription)

Якщо `BLoC A` залежить від `BLoC B`, є 2 підходи:
   • Лише **сайт-ефекти (`BlocListener`)**.
   • Повна залежність через **StreamSubscription**.

✅ **1. Використання BlocListener для Side Effects**
-----------------------------------------------------------
BlocListener<ColorBloc, ColorState>(
  listenWhen: (previous, current) => previous.color != current.color,
  listener: (context, state) {
    if (state.color == Colors.red) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Color changed to red!'),
      ));
    }
  },
  child: MyWidget(),
);
-----------------------------------------------------------

✅ **2. Повна підписка через StreamSubscription**
-----------------------------------------------------------
class CounterBloc extends Bloc<CounterEvent, int> {
  final ColorBloc colorBloc;
  late final StreamSubscription colorSubscription;

  CounterBloc(this.colorBloc) : super(0) {
    colorSubscription = colorBloc.stream.listen((colorState) {
      if (colorState.color == Colors.red) {
        add(IncrementEvent());
      }
    });

    on<IncrementEvent>((event, emit) {
      emit(state + 1);
    });
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
-----------------------------------------------------------


==========================================================
**********************************************************
==========================================================


📌 Оптимізація та найкращі практики
==========================================================

✅ **1. Використовувати buildWhen у BlocBuilder**
-----------------------------------------------------------
BlocBuilder<MyBloc, MyState>(
  buildWhen: (previous, current) => previous.counter != current.counter,
  builder: (context, state) {
    return Text('${state.counter}');
  },
);
-----------------------------------------------------------

✅ **2. Використовувати debounceTime для частих подій**
-----------------------------------------------------------
EventTransformer<E> debounceSequential<E>() {
  return (events, mapper) {
    return events.debounceTime(Duration(milliseconds: 300)).switchMap(mapper);
  };
}
-----------------------------------------------------------

✅ **3. Перевіряти перед emit()**
-----------------------------------------------------------
void safeEmit(MyBloc bloc, MyState newState) {
  if (!bloc.isClosed) bloc.emit(newState);
}
-----------------------------------------------------------

==========================================================
📌 **Висновки**
==========================================================
• **Cubit**: Простий, має `emit()`, не використовує Events.
• **BLoC**: Використовує **Event-driven** підхід, працює з `Stream`.
• **Оптимізація**:
  - Використовувати `buildWhen`.
  - Використовувати `debounceTime`.
  - Перевіряти `isClosed` перед `emit()`.
• **Залежність між BLoC**:
  - `BlocListener` для **сайд-ефектів**.
  - `StreamSubscription` для **повної залежності**.

==========================================================
**********************************************************
==========================================================


*/
