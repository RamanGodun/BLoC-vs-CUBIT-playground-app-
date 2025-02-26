import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/counter/blocs/_counter_bloc/counter_bloc.dart';
import '../../../features/counter/cubits/_counter/counter_cubit.dart';
import '../app_state/app_state_cubit.dart';
import 'counter_manager.dart';

class CounterFactory {
  static CounterManager create(BuildContext context) {
    final isUseBloc = context.read<AppStateCubit>().state.isUseBloc;
    return isUseBloc
        ? BlocCounterManager(context.read<CounterOnBloc>())
        : CubitCounterManager(context.read<CounterOnCubit>());
  }
}
