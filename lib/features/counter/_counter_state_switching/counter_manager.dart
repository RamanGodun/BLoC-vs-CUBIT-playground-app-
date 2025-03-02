import '../counter_on_bloc/counter_bloc.dart';
import '../counter_on_cubit/counter_cubit.dart';

abstract class CounterManager {
  int get currentCounter;
  void increment();
  void decrement();
}

class BlocCounterManager implements CounterManager {
  final CounterOnBloc _bloc;

  BlocCounterManager(this._bloc);

  @override
  int get currentCounter => _bloc.state.counter;

  @override
  void increment() => _bloc.add(IncrementCounterEvent());

  @override
  void decrement() => _bloc.add(DecrementCounterEvent());
}

class CubitCounterManager implements CounterManager {
  final CounterOnCubit _cubit;

  CubitCounterManager(this._cubit);

  @override
  int get currentCounter => _cubit.state.counter;

  @override
  void increment() => _cubit.increment();

  @override
  void decrement() => _cubit.decrement();
}
