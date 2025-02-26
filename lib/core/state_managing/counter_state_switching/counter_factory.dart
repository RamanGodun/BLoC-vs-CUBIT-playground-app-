import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* BLoC */
import '../app_settings_on_bloc/app_settings_bloc.dart' as bloc_state;
import '../../../features/counter/counter_on_bloc/counter_bloc.dart';

/* Cubit */
import '../app_settings_on_cubit/ap_settings_cubit.dart' as cubit_state;
import '../../../features/counter/counter_on_cubit/counter_cubit.dart';

import 'counter_manager.dart';

class CounterFactory {
  static CounterManager create(BuildContext context, {required bool useBloc}) {
    return useBloc
        ? BlocCounterManager(context.read<CounterOnBloc>())
        : CubitCounterManager(context.read<CounterOnCubit>());
  }

  static bool isUseBloc(BuildContext context, {required bool isBlocActive}) {
    return isBlocActive
        ? context.read<bloc_state.AppSettingsOnBloc>().state.isUseBloc
        : context.read<cubit_state.AppSettingsOnCubit>().state.isUseBloc;
  }
}
