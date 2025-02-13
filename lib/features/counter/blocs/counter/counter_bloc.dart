import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/*
🟢 `CounterBloc`: Основний клас BLoC, що містить бізнес-логіку для управління станом `CounterState`.
- Обробляє події `IncrementCounterEvent` і `DecrementCounterEvent`.
- Використовує `emit()` для оновлення стану.
- Всі події обробляються в методах `_incrementCounter()` та `_decrementCounter()`.
*/
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  /*
  🟢 Конструктор `CounterBloc`
  - Викликає `super(CounterState.initial())`, що встановлює початковий стан `counter = 0`.
  - Реєструє обробники подій через `on<Event>((event, emit) {...})`.
  */
  CounterBloc() : super(CounterState.initial()) {
    /*
    🟢 Обробка `IncrementCounterEvent`
    - При виклику цієї події збільшує `counter` на 1.
    - Використовує `emit()`, щоб оновити стан.
    */
    on<IncrementCounterEvent>(_incrementCounter);

    /*
    🟢 Обробка `DecrementCounterEvent`
    - При виклику цієї події зменшує `counter` на 1.
    - Логіка винесена в окремий метод `_decrementCounter()`.
    */
    on<DecrementCounterEvent>(_decrementCounter);
  }

  /*
  🟢 _incrementCounter() – обробка збільшення значення лічильника.
  - Використовується в `on<IncrementCounterEvent>()`.
  - Викликає `emit()`, передаючи новий стан, де `counter` збільшується на 1.
  */
  void _incrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  /*
  🟢 _decrementCounter() – обробка зменшення значення лічильника.
  - Використовується в `on<DecrementCounterEvent>()`.
  - Викликає `emit()`, передаючи новий стан, де `counter` зменшується на 1.
  */
  void _decrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
