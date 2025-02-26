part of 'app_settings_bloc.dart';

class AppSettingsStateOnBloc extends Equatable {
  final bool isUseBloc;
  final bool isDarkThemeForBloc;
  final bool isDarkThemeForCubit;

  const AppSettingsStateOnBloc({
    required this.isUseBloc,
    required this.isDarkThemeForBloc,
    required this.isDarkThemeForCubit,
  });

  factory AppSettingsStateOnBloc.initial() {
    return const AppSettingsStateOnBloc(
      isUseBloc: true,
      isDarkThemeForBloc: false,
      isDarkThemeForCubit: false,
    );
  }

  AppSettingsStateOnBloc copyWith({
    bool? isUseBloc,
    bool? isDarkThemeForBloc,
    bool? isDarkThemeForCubit,
  }) {
    return AppSettingsStateOnBloc(
      isUseBloc: isUseBloc ?? this.isUseBloc,
      isDarkThemeForBloc: isDarkThemeForBloc ?? this.isDarkThemeForBloc,
      isDarkThemeForCubit: isDarkThemeForCubit ?? this.isDarkThemeForCubit,
    );
  }

  @override
  List<Object> get props =>
      [isUseBloc, isDarkThemeForBloc, isDarkThemeForCubit];
}
