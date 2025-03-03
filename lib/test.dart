/*

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/app_bloc_observer.dart';
import 'core/config/app_config.dart';
import 'core/config/app_routes.dart';
import 'core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import 'core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import 'features/counter/counter_on_bloc/counter_bloc.dart';
import 'features/counter/counter_on_cubit/counter_cubit.dart';
import 'features/counter_depends_on_color/color_on_bloc/color_bloc.dart';
import 'features/counter_depends_on_color/color_on_cubit/color_cubit.dart';
import 'features/counter_depends_on_color/counter_on_bloc/counter_bloc.dart';
import 'features/counter_depends_on_color/counter_on_cubit/counter_which_depends_on_color_cubit.dart';
import 'features/events_transformer/bloc/counter_bloc.dart';
import 'features/counter_on_hydrated_bloc/counter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final prefs = await SharedPreferences.getInstance();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(
    MultiBlocProvider(
      providers: AppConfig.useBloc
          ? [
              BlocProvider(create: (_) => AppSettingsOnBloc()),
              BlocProvider(create: (_) => CounterOnBloc()),
              BlocProvider(create: (_) => ColorOnBloc()),
              BlocProvider(
                create: (context) => CounterBlocWhichDependsOnColorBLoC(
                  colorBloc: context.read<ColorOnBloc>(),
                ),
              ),
              BlocProvider(create: (_) => CounterBlocWithTransformers()),
              BlocProvider(create: (_) => HydratedCounterBloc()),
            ]
          : [
              BlocProvider(create: (_) => AppSettingsOnCubit(prefs)),
              BlocProvider(create: (_) => CounterOnCubit()),
              BlocProvider(create: (_) => ColorOnCubit()),
              BlocProvider(
                create: (context) => CounterCubitWhichDependsOnColorCubit(
                  colorCubit: context.read<ColorOnCubit>(),
                ),
              ),
            ],
      child: Builder(
        builder: (context) => const AppWrapper(),
      ),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConfig.useBloc
        ? BlocBuilder<AppSettingsOnBloc, AppSettingsStateOnBloc>(
            builder: (context, state) {
              final isDarkMode = state.isDarkThemeForBloc;
              return buildMaterialApp(isDarkMode);
            },
          )
        : BlocBuilder<AppSettingsOnCubit, AppSettingsStateOnCubit>(
            builder: (context, state) {
              final isDarkMode = state.isDarkThemeForCubit;
              return buildMaterialApp(isDarkMode);
            },
          );
  }

  MaterialApp buildMaterialApp(bool isDarkMode) {
    return MaterialApp(
      title: 'BLoC & Cubit',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}


class AppConfig {
  ! When changing state-shape
  static bool useBloc = true; // ! true якщо BLoC, false якщо Cubit 👈
}



class CounterDependsOnColorPage extends StatelessWidget {
  const CounterDependsOnColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterDependsOnColorFactory.create(context);
    final isUsingBloc = AppConfig.useBloc;




class CounterDependsOnColorFactory {
  static CounterDependsOnColorManager create(BuildContext context) {
    return AppConfig.useBloc
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


 */
