part of 'app_settings_cubit.dart';

class AppSettingsStateOnCubit extends Equatable {
  final bool isUseBloc;
  final bool isDarkThemeForBloc;
  final bool isDarkThemeForCubit;

  const AppSettingsStateOnCubit({
    required this.isUseBloc,
    required this.isDarkThemeForBloc,
    required this.isDarkThemeForCubit,
  });

  factory AppSettingsStateOnCubit.initial() {
    return const AppSettingsStateOnCubit(
      isUseBloc: true,
      isDarkThemeForBloc: false,
      isDarkThemeForCubit: false,
    );
  }

  AppSettingsStateOnCubit copyWith({
    bool? isUseBloc,
    bool? isDarkThemeForBloc,
    bool? isDarkThemeForCubit,
  }) {
    return AppSettingsStateOnCubit(
      isUseBloc: isUseBloc ?? this.isUseBloc,
      isDarkThemeForBloc: isDarkThemeForBloc ?? this.isDarkThemeForBloc,
      isDarkThemeForCubit: isDarkThemeForCubit ?? this.isDarkThemeForCubit,
    );
  }

  @override
  List<Object> get props =>
      [isUseBloc, isDarkThemeForBloc, isDarkThemeForCubit];
}
