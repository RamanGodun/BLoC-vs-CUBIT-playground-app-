part of 'app_state_cubit.dart';

class AppState extends Equatable {
  final bool isUseBloc;
  final bool isDarkThemeForBloc;
  final bool isDarkThemeForCubit;

  const AppState({
    required this.isUseBloc,
    required this.isDarkThemeForBloc,
    required this.isDarkThemeForCubit,
  });

  factory AppState.initial() {
    return const AppState(
      isUseBloc: true,
      isDarkThemeForBloc: false,
      isDarkThemeForCubit: false,
    );
  }

  AppState copyWith({
    bool? isUseBloc,
    bool? isDarkThemeForBloc,
    bool? isDarkThemeForCubit,
  }) {
    return AppState(
      isUseBloc: isUseBloc ?? this.isUseBloc,
      isDarkThemeForBloc: isDarkThemeForBloc ?? this.isDarkThemeForBloc,
      isDarkThemeForCubit: isDarkThemeForCubit ?? this.isDarkThemeForCubit,
    );
  }

  @override
  List<Object> get props =>
      [isUseBloc, isDarkThemeForBloc, isDarkThemeForCubit];
}
