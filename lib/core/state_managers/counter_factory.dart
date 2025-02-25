import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_manager.dart';
import '../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../features/counter/cubits/_counter/counter_cubit.dart';
import 'package:provider/provider.dart';
import 'provider_4_state_shape_switching.dart';

class CounterFactory {
  static final CounterFactory _instance = CounterFactory._internal();

  factory CounterFactory() => _instance;

  CounterFactory._internal();

  static final Map<String, CounterManager> _cache = {};

  CounterManager create(BuildContext context) {
    final useBloc = context.read<Provider4StateShapeSwitching>().useBloc;
    final key = useBloc ? 'bloc' : 'cubit';

    return _cache.putIfAbsent(
      key,
      () => useBloc
          ? BlocCounterManager(context.read<CounterOnBloc>())
          : CubitCounterManager(context.read<CounterOnCubit>()),
    );
  }
}
