import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/// 🎯 CounterBloc, який демонструє різні Event Transformers.
class CounterBlocWithTransformers
    extends Bloc<CounterEvent, CounterStateWithTransformers> {
  CounterBlocWithTransformers()
      : super(CounterStateWithTransformers.initial()) {
    // ⏳ Droppable - ігнорує нові події, якщо поточна ще виконується.
    on<IncrementCounterEvent>(
      _handleIncrementCounterEvent,
      transformer: droppable(),
    );

    // 🔄 Restartable - скасовує попередній виклик і запускає новий.
    on<DecrementCounterEvent>(
      _handleDecrementCounterEvent,
      transformer: restartable(),
    );

    // 🎯 Окремий приклад для об'єднання подій в одну логіку:
    /*
    on<CounterEvent>(
      (event, emit) async {
        switch (event) {
          case IncrementCounterEvent():
            await _handleIncrementCounterEvent(event, emit);
          case DecrementCounterEvent():
            await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: sequential(), // Події виконуються послідовно.
    );
    */
  }

  /// ⏳ Droppable: Ігнорує нові події, якщо поточна ще виконується.
  Future<void> _handleIncrementCounterEvent(IncrementCounterEvent event,
      Emitter<CounterStateWithTransformers> emit) async {
    await Future.delayed(const Duration(seconds: 3)); 
    emit(state.copyWith(counter: state.counter + 1));
  }

  /// 🔄 Restartable: Скасовує попередній запит і виконує останній.
  Future<void> _handleDecrementCounterEvent(DecrementCounterEvent event,
      Emitter<CounterStateWithTransformers> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(counter: state.counter - 1));
  }
}
