import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* BLoCs */
import 'core/config/app_bloc_observer.dart';
import 'core/config/app_routes.dart';
import 'core/state_managing/app_settings_on_bloc/app_settings_bloc.dart'
    as bloc_state; // ! When using BLOC as a state-shape handler

/* CUBITS */
// import 'core/state_managing/app_settings_on_cubit/app_settings_cubit.dart'
//     as cubit_state; // ! When using CUBIT as a state-shape handler
import 'features/counter/counter_on_bloc/counter_bloc.dart';
import 'features/counter/counter_on_cubit/counter_cubit.dart';
import 'features/counter_depends_on_color/color_on_bloc/color_bloc.dart';
import 'features/counter_depends_on_color/color_on_cubit/color_cubit.dart';
import 'features/counter_depends_on_color/counter_on_bloc/counter_bloc.dart';
import 'features/counter_depends_on_color/counter_on_cubit/counter_which_depends_on_color_cubit.dart';
import 'features/events_transformer/bloc/counter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        /* CUBIT */
        // BlocProvider(
        //     create: (_) =>
        //         cubit_state.AppSettingsOnCubit(prefs)), // ! When using CUBIT as a state-shape handler
        BlocProvider(create: (_) => CounterOnCubit()),
        BlocProvider<ColorOnCubit>(
            create: (context) => ColorOnCubit()), // When using CUBIT
        BlocProvider<CounterCubitWhichDependsOnColorCubit>(
            create: (context) => CounterCubitWhichDependsOnColorCubit(
                colorCubit: context.read<ColorOnCubit>())), // When using CUBIT

        /* BLOC */
        BlocProvider(
            create: (_) => bloc_state.AppSettingsOnBloc(
                prefs)), // ! When using BLOC as a state-shape handler
        BlocProvider(create: (_) => CounterOnBloc()),

        BlocProvider<ColorOnBloc>(
            create: (context) => ColorOnBloc()), // When using BLOC
        BlocProvider<CounterBlocWhichDependsOnColorBLoC>(
            create: (context) => CounterBlocWhichDependsOnColorBLoC(
                colorBloc: context.read<ColorOnBloc>())), // When using BLOC
        BlocProvider(create: (_) => CounterBlocWithTransformers()),
      ],
      child: const AppWrapper(),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //   ! When using BLOC as a state-shape handler
    return BlocBuilder<bloc_state.AppSettingsOnBloc,
        bloc_state.AppSettingsStateOnBloc>(
      // ! When using CUBIT as a state-shape handler
      // return BlocBuilder<cubit_state.AppSettingsOnCubit,
      //     cubit_state.AppSettingsStateOnCubit>(
      builder: (context, state) {
        final isDarkMode = state.isUseBloc
            ? state.isDarkThemeForBloc
            : state.isDarkThemeForCubit;

        return MaterialApp(
          title: 'BLoC & Cubit',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
