part of 'app_settings_bloc.dart';

sealed class AppSettingsEvents extends Equatable {
  const AppSettingsEvents();

  @override
  List<Object> get props => [];
}

final class ToggleUseBlocEvent extends AppSettingsEvents {}

final class LoadAppStateEvent extends AppSettingsEvents {}

final class ToggleThemeEvent extends AppSettingsEvents {
  final bool isDarkMode;

  const ToggleThemeEvent({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
