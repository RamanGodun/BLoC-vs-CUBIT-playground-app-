import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* BLoC */
import '../../../features/counter_depends_on_color/counter_on_cubit/counter_which_depends_on_color_cubit.dart';
// import '../app_settings_on_bloc/app_settings_bloc.dart' as bloc_state;
import '../../../features/counter_depends_on_color/counter_on_bloc/counter_bloc.dart';
import '../../../features/counter_depends_on_color/color_on_bloc/color_bloc.dart';

/* CUBIT */
import '../app_settings_on_cubit/app_settings_cubit.dart' as cubit_state;
import '../../../features/counter_depends_on_color/color_on_cubit/color_cubit.dart';
import 'counter_depends_on_color_manager.dart';

class CounterDependsOnColorFactory {
  /// Метод `create` повертає правильний `CounterDependsOnColorManager` на основі BLoC або Cubit
  static CounterDependsOnColorManager create(BuildContext context) {
    // final useBloc =
    //     context.watch<bloc_state.AppSettingsOnBloc>().state.isUseBloc; // ! When using BLOC
    final useBloc = context
        .watch<cubit_state.AppSettingsOnCubit>()
        .state
        .isUseBloc; // ! When using CUBIT
//
    return useBloc
        ? BlocCounterDependsOnColorManager(
            context.read<CounterBlocWhichDependsOnColorBLoC>(),
            context.read<ColorOnBloc>(),
          )
        : CubitCounterDependsOnColorManager(
            context.read<CounterCubitWhichDependsOnColorCubit>(),
            context.read<ColorOnCubit>(),
          );
  }
}
