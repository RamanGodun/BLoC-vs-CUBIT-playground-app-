import '../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../features/counter/cubits/_counter/counter_cubit.dart';

// 🟢 Interface for Counter Manager
abstract class CounterManager {
  int get currentCounter;
  void increment();
  void decrement();
}

// 🟢 ============= Interface implementation ============== 🟢 //

// 🟢 BLoC Implementation of CounterManager
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

// 🟢 Cubit Implementation of CounterManager
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
