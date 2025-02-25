part of 'counter_bloc.dart';

/*
🟢 CounterState: Описує стан BLoC.
- Використовує `Equatable` для порівняння об'єктів та уникнення зайвих оновлень UI.
- Містить змінну `counter`, яка представляє поточний стан лічильника.
*/
final class CounterOnBLoCState extends Equatable {
  final int counter;

  const CounterOnBLoCState({
    required this.counter,
  });

  /*
  🟢 Фабричний конструктор `initial()`
  - Використовується для початкового стану лічильника (counter = 0).
  */
  factory CounterOnBLoCState.initial() {
    return const CounterOnBLoCState(counter: 0);
  }

  /*
  🟢 Визначає, які властивості беруть участь у порівнянні станів.
  - Якщо значення `counter` не змінилося, BLoC не буде перерисовувати UI.
  */
  @override
  List<Object> get props => [counter];

  /*
  🟢 Зручний `toString()`
  - Допомагає дебажити, логуючи стан у зрозумілому вигляді.
  */
  @override
  String toString() => 'CounterState(counter: $counter)';

  /*
  🟢 copyWith() дозволяє створювати копії стану із зміненими значеннями.
  - Якщо передане значення `counter` є `null`, використовується поточне значення.
  */
  CounterOnBLoCState copyWith({
    int? counter,
  }) {
    return CounterOnBLoCState(
      counter: counter ?? this.counter,
    );
  }
}
