import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_manager.dart';
import '../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../features/counter/cubits/_counter/counter_cubit.dart';
import 'use_bloc_provider.dart';

class CounterFactory {
  static CounterManager create(BuildContext context) {
    final useBloc = UseBlocProvider.of(context).useBloc;

    return useBloc
        ? BlocCounterManager(context.read<CounterOnBloc>())
        : CubitCounterManager(context.read<CounterOnCubit>());
  }
}
