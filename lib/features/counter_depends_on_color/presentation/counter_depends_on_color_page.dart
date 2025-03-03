import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/pages/theme_page.dart';
import '../../../core/config/app_config.dart';
import '../../../core/state_managing/app_settings_on_cubit/app_settings_cubit.dart';
import '../../../core/state_managing/app_settings_on_bloc/app_settings_bloc.dart';
import '../_state_switching_of_counter_which_depends_on_color/factory_for_counter_which_depends_on_color.dart';
import '../../../presentation/text_widget.dart';
import '../../../core/utils/helpers.dart';
import '../color_on_bloc/color_bloc.dart';
import '../color_on_cubit/color_cubit.dart';
import '../counter_on_bloc/counter_bloc.dart';
import '../counter_on_cubit/counter_which_depends_on_color_cubit.dart';
part 'counter_display_w.dart';

class CounterDependsOnColorPage extends StatelessWidget {
  const CounterDependsOnColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterManager = CounterDependsOnColorFactory.create(context);
    // Color backgroundColor = counterManager.getBackgroundColor();
    final isUsingBlocInCurrentStateShape = AppConfig.isUsingBlocStateShape
        ? context
            .select<AppSettingsOnBloc, bool>((bloc) => bloc.state.isUseBloc)
        : context
            .select<AppSettingsOnCubit, bool>((cubit) => cubit.state.isUseBloc);

    final backgroundColor = isUsingBlocInCurrentStateShape
        ? context.select<ColorOnBloc, Color>(
            (bloc) => bloc.state.color,
          )
        : context.select<ColorOnCubit, Color>(
            (cubit) => cubit.state.color,
          );

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
