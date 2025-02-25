import 'package:bloc_by_korean/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/* BLoCs */
import 'core/state_managers/use_bloc_provider.dart';
import 'features/counter/blocs/_theme_bloc/theme_bloc.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';

/* CUBITS */
import 'features/counter/cubits/_counter/counter_cubit.dart';
import 'features/counter/cubits/_theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UseBlocProvider()),
        BlocProvider(create: (_) => CounterOnBloc()),
        BlocProvider(create: (_) => CounterOnCubit()),
        BlocProvider(create: (_) => ThemeOnBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC or Cubit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
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