import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/constants.dart';

/* BLoCs
 */
import 'features/counter/blocs/_theme_bloc/theme_bloc.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';
import 'features/counter/blocs/color/color_bloc.dart';
import 'features/counter/blocs/counter_which_depends_on_color/counter_bloc.dart';

/* CUBITS
 */
import 'features/counter/cubits/counter/counter_cubit.dart';
import 'features/counter/cubits/theme/theme_cubit.dart';
import 'features/counter/cubits/color/color_cubit.dart';
import 'features/counter/cubits/counter_which_depends_on_color/counter_which_depends_on_color_cubit.dart';

/* PRESENTATION
 */
import 'features/counter/presentation/counter_depends_on_color_page.dart';
// import 'features/counter/presentation/counter_page_4_cubit.dart';
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
        /*
         BLoCs
         */
        BlocProvider<CounterOnBloc>(create: (context) => CounterOnBloc()),
        BlocProvider<ThemeOnBloc>(create: (context) => ThemeOnBloc()),
        BlocProvider<ColorOnBloc>(create: (context) => ColorOnBloc()),
        BlocProvider<CounterBlocWhichDependsOnColorBLoC>(
          create: (context) => CounterBlocWhichDependsOnColorBLoC(
            colorBloc: context.read<ColorOnBloc>(),
          ),
        ),

        /*
         CUBITS
         */
        BlocProvider<CounterOnCubit>(create: (context) => CounterOnCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<ColorCubit>(create: (context) => ColorCubit()),
        BlocProvider<CounterCubitWhichDependsOnColorCubit>(
            create: (context) => CounterCubitWhichDependsOnColorCubit(
                  colorCubit: context.read<
                      ColorCubit>(), // need only when don't use BlocListener in UI
                )),
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
                // const MyHomePage4Cubit(), //  when use Cubit for counter
                const CounterDependsOnColorPage(),
          );
        },
      ),
    );
  }
}
