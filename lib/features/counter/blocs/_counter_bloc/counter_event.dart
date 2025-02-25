part of 'counter_bloc.dart';

/*
🟢 Абстрактний клас `CounterEvent` представляє події, які може обробляти `CounterBloc`.
- Використовує `Equatable`, щоб уникнути зайвих оновлень UI при порівнянні об'єктів.
*/
sealed class CounterOnBLoCEvent extends Equatable {
  const CounterOnBLoCEvent();

  @override
  List<Object> get props => [];
}

/*
🟢 Подія `IncrementCounterEvent` 
- Відповідає за збільшення значення лічильника.
- Використовується у `Bloc` для обробки відповідної логіки.
*/
final class IncrementCounterEvent extends CounterOnBLoCEvent {}

/*
🟢 Подія `DecrementCounterEvent` 
- Відповідає за зменшення значення лічильника.
*/
final class DecrementCounterEvent extends CounterOnBLoCEvent {}
