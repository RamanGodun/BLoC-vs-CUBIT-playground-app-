import 'package:bloc_by_korean/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* BLoCs */
import 'core/presentation/constants.dart';
import 'core/state_managers/provider_4_state_shape_switching.dart';
import 'features/counter/blocs/_theme_bloc/theme_bloc.dart';
import 'features/counter/blocs/_counter_bloc/counter_bloc.dart';

/* CUBITS */
import 'features/counter/cubits/_counter/counter_cubit.dart';
import 'features/counter/cubits/_theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Provider4StateShapeSwitching()),
        BlocProvider(create: (_) => CounterOnBloc()),
        BlocProvider(create: (_) => CounterOnCubit()),
        BlocProvider(create: (_) => ThemeOnBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: AppWrapper(initialDarkMode: isDarkMode),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  final bool initialDarkMode;

  const AppWrapper({super.key, required this.initialDarkMode});

  @override
  Widget build(BuildContext context) {
    final useBloc = context.watch<Provider4StateShapeSwitching>().useBloc;

    return useBloc
        ? BlocBuilder<ThemeOnBloc, ThemeOnBLoCState>(
            builder: (context, state) => _buildMaterialApp(state.appTheme),
          )
        : BlocBuilder<ThemeCubit, CubitThemeState>(
            builder: (context, state) => _buildMaterialApp(state.appTheme),
          );
  }

  MaterialApp _buildMaterialApp(AppTheme appTheme) {
    return MaterialApp(
      title: 'BLoC or Cubit',
      debugShowCheckedModeBanner: false,
      theme: appTheme == AppTheme.light
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
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
