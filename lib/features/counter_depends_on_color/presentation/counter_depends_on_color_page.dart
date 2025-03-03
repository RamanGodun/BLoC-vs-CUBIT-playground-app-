import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/pages/theme_page.dart';
import '../../../core/config/app_config.dart';
import '../../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import '../../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import '../../../core/state_managing/_state_switching_of_counter_which_depends_on_color/factory_for_counter_which_depends_on_color.dart';
import '../color_on_bloc/color_bloc.dart';
import '../color_on_cubit/color_cubit.dart';
import '../../../presentation/widgets/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../counter_on_bloc/counter_bloc.dart';
import '../counter_on_cubit/counter_which_depends_on_color_cubit.dart';

class CounterDependsOnColorPage extends StatelessWidget {
  const CounterDependsOnColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterDependsOnColorFactory.create(context);

    final isUsingBloc = AppConfig.isUsingBlocStateShape
        ? context
            .select<AppSettingsOnBloc, bool>((bloc) => bloc.state.isUseBloc)
        : context
            .select<AppSettingsOnCubit, bool>((cubit) => cubit.state.isUseBloc);

    final backgroundColor = isUsingBloc
        ? context.watch<ColorOnBloc>().state.color
        : context.watch<ColorOnCubit>().state.color;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Helpers.pushTo(context, const ThemePage()),
            icon: const Icon(Icons.sunny),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: counterManager.changeColor,
              child: const TextWidget('Change Color', TextType.button),
            ),
            const SizedBox(height: 20.0),
            const CounterDisplayWidget(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => counterManager.changeCounter(),
              child: const TextWidget('Change Counter', TextType.button),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterDisplayWidget extends StatelessWidget {
  const CounterDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isUsingBloc = AppConfig.isUsingBlocStateShape
        ? context
            .select<AppSettingsOnBloc, bool>((bloc) => bloc.state.isUseBloc)
        : context
            .select<AppSettingsOnCubit, bool>((cubit) => cubit.state.isUseBloc);

    return isUsingBloc
        ? BlocBuilder<CounterBlocWhichDependsOnColorBLoC,
            CounterStateWhichDependsOnColorBloc>(
            buildWhen: (previous, current) =>
                previous.counter != current.counter,
            builder: (context, state) {
              print('[UI REBUILD - BLoC] Counter Value: ${state.counter}');
              return TextWidget('${state.counter}', TextType.headline);
            },
          )
        : BlocBuilder<CounterCubitWhichDependsOnColorCubit,
            CounterCubitStateWhichDependsOnColorCubit>(
            buildWhen: (previous, current) =>
                previous.counter != current.counter,
            builder: (context, state) {
              print('[UI REBUILD - Cubit] Counter Value: ${state.counter}');
              return TextWidget('${state.counter}', TextType.headline);
            },
          );
  }
}
