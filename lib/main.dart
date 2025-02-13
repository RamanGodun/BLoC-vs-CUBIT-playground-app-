import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/constants.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';
import 'features/counter/blocs/_theme_bloc/theme_bloc.dart';
import 'features/counter/cubit/counter/counter_cubit.dart';
import 'features/counter/presentation/counter_page_4_cubit.dart';
import 'features/counter/cubit/theme/theme_cubit.dart';

// import 'features/counter/blocs/presentation/home_page_4_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      // child: BlocBuilder<ThemeBloc, ThemeState>( // when use BLoc for theme
      child: BlocBuilder<ThemeCubit, CubitThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'BLoC or Cubit',
            debugShowCheckedModeBanner: false,
            theme: themeState.appTheme == AppTheme.light
                ? ThemeData.light(useMaterial3: true)
                : ThemeData.dark(useMaterial3: true),
            home:
                // const MyHomePage4BLoC(), // when use BLoC for counter
                const MyHomePage4Cubit(),
          );
        },
      ),
    );
  }
}
