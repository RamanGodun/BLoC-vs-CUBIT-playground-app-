// Counter Factory
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_manager.dart';
import '../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../features/counter/cubits/_counter/counter_cubit.dart';

class CounterFactory {
  static CounterManager create(BuildContext context, {required bool useBloc}) {
    return useBloc
        ? BlocCounterManager(context.read<CounterOnBloc>())
        : CubitCounterManager(context.read<CounterOnCubit>());
  }
}
