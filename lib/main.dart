import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/* BLoCs */
import 'core/config/app_bloc_observer.dart';
import 'core/config/app_config.dart';
import 'core/config/app_routes.dart';
import 'core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import 'features/counter/counter_on_bloc/counter_bloc.dart';
import 'features/counter_depends_on_color/color_on_bloc/color_bloc.dart';
import 'features/counter_depends_on_color/counter_on_bloc/counter_bloc.dart';
import 'features/events_transformer/bloc/counter_bloc.dart';
import 'features/counter_on_hydrated_bloc/hydrated_counter_bloc/counter_bloc.dart';

/* CUBITS */
import 'core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import 'features/counter/counter_on_cubit/counter_cubit.dart';
import 'features/counter_depends_on_color/color_on_cubit/color_cubit.dart';
import 'features/counter_depends_on_color/counter_on_cubit/counter_which_depends_on_color_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌐 Initialize BLoC Observer for state management monitoring
  Bloc.observer = AppBlocObserver();

  // 💾 Initialize Hydrated BLoC storage for persisting state
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        // 🟦 BLoC Providers
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

        // 🟧 Cubit Providers
        BlocProvider(create: (_) => AppSettingsOnCubit()),
        BlocProvider(create: (_) => CounterOnCubit()),
        BlocProvider(create: (_) => ColorOnCubit()),
        BlocProvider(
          create: (context) => CounterCubitWhichDependsOnColorCubit(
            colorCubit: context.read<ColorOnCubit>(),
          ),
        ),
      ],
      child: const AppWrapper(),
    ),
  );
}

/// 🏠 [AppWrapper] is the root widget of the application.
/// It dynamically selects between BLoC [AppSettingsOnBloc] and Cubit [AppSettingsOnCubit]
/// based on the [AppConfig] configuration.
class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConfig.isUsingBlocStateShape
        ? BlocBuilder<AppSettingsOnBloc, AppSettingsStateOnBloc>(
            builder: (context, state) {
              // 🎨 Determine the theme mode based on BLoC state
              final isDarkMode = state.isUseBloc
                  ? state.isDarkThemeForBloc
                  : state.isDarkThemeForCubit;

              return _buildMaterialApp(isDarkMode);
            },
          )
        : BlocBuilder<AppSettingsOnCubit, AppSettingsStateOnCubit>(
            builder: (context, state) {
              // 🎨 Determine the theme mode based on Cubit state
              final isDarkMode = state.isUseBloc
                  ? state.isDarkThemeForBloc
                  : state.isDarkThemeForCubit;

              return _buildMaterialApp(isDarkMode);
            },
          );
  }

  /// 🌈 Builds the [MaterialApp] with dynamic theming
  MaterialApp _buildMaterialApp(bool isDarkMode) {
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
