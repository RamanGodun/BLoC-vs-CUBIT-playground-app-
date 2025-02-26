import 'package:bloc_by_korean/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* BLoCs */
import 'core/state_managers/app_state/app_state_cubit.dart';
import 'features/counter/blocs/_theme_bloc/theme_bloc.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';

/* CUBITS */
import 'features/counter/cubits/_counter/counter_cubit.dart';
import 'features/counter/cubits/_theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppStateCubit(prefs)),
        BlocProvider(create: (_) => CounterOnBloc()),
        BlocProvider(create: (_) => CounterOnCubit()),
        BlocProvider(create: (_) => ThemeOnBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const AppWrapper(),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStateCubit, AppState>(
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
