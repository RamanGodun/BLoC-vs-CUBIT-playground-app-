import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterOnCubit extends Cubit<CounterOnCubitState> {
  CounterOnCubit() : super(CounterOnCubitState.initial());

  void increment() {
    final newState = state.copyWith(counter: state.counter + 1);
    print(newState);
    emit(newState);
  }

/*
for loggin may use use CubitObserver.onXhange() or, if no need in logging, use next: 
  void increment() {
    emit(state.copyWith(counter: state.counter + 1));
  }
 */

  void decrement() {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
