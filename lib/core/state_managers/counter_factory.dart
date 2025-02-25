import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_manager.dart';
import '../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../features/counter/cubits/_counter/counter_cubit.dart';
import 'package:provider/provider.dart';
import 'use_bloc_provider.dart';

class CounterFactory {
  static final CounterFactory _instance = CounterFactory._internal();

  factory CounterFactory() => _instance;

  CounterFactory._internal();

  static final Map<String, CounterManager> _cache = {};

  CounterManager create(BuildContext context) {
    final useBloc = context.read<UseBlocProvider>().useBloc;
    final key = useBloc ? 'bloc' : 'cubit';

    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }

    final manager = useBloc
        ? BlocCounterManager(context.read<CounterOnBloc>())
        : CubitCounterManager(context.read<CounterOnCubit>());

    _cache[key] = manager;
    return manager;
  }
}
