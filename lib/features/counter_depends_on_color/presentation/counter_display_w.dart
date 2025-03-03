part of 'counter_depends_on_color_page.dart';

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
