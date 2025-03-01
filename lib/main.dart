import 'package:bloc_by_korean/core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* BLoCs */
import 'core/state_managing/app_settings_on_bloc/app_settings_bloc.dart'
    as bloc_state;

/* CUBITS */
// import 'core/state_managers/app_settings_on_cubit/ap_settings_cubit.dart' as cubit_state;

import 'features/counter/counter_on_bloc/counter_bloc.dart';
import 'features/counter/counter_on_cubit/counter_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => cubit_state.AppsettingsOnCubit(prefs)), // ! When using CUBIT
        BlocProvider(
            create: (_) =>
                bloc_state.AppSettingsOnBloc(prefs)), // ! When using BLOC
        BlocProvider(create: (_) => CounterOnBloc()),
        BlocProvider(create: (_) => CounterOnCubit()),
      ],
      child: const AppWrapper(),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bloc_state.AppSettingsOnBloc,
        bloc_state.AppSettingsStateOnBloc>(
      // BlocBuilder<cubit_state.AppSettingsOnCubit,
      //  cubit_state.AppSettingsStateOnCubit>( // ! When using CUBIT
      builder: (context, state) {
        final isDarkMode = state.isUseBloc
            ? state.isDarkThemeForBloc
            : state.isDarkThemeForCubit;

        return MaterialApp(
          title: 'BLoC or Cubit',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          home: const HomePage(),
        );
      },
    );
  }
}

/*

  BlocProvider<ColorOnBloc>(create: (context) => ColorOnBloc()),
        BlocProvider<CounterBlocWhichDependsOnColorBLoC>(
          create: (context) => CounterBlocWhichDependsOnColorBLoC(
            colorBloc: context.read<ColorOnBloc>(),
          ),
        ),

 BlocProvider<ColorCubit>(create: (context) => ColorCubit()),
        BlocProvider<CounterCubitWhichDependsOnColorCubit>(
            create: (context) => CounterCubitWhichDependsOnColorCubit(
                  colorCubit: context.read<
                      ColorCubit>(), // need only when don't use BlocListener in UI
                )),

 */
