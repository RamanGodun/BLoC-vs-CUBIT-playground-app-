part of 'app_settings_bloc.dart';

/// Base class for all events related to `AppSettingsOnBloc`.
sealed class AppSettingsEvents extends Equatable {
  const AppSettingsEvents();

  @override
  List<Object> get props => [];
}

/// Event to toggle between BLoC and Cubit state management modes.
final class ToggleUseBlocEvent extends AppSettingsEvents {}

/// Event to load the app's state (if needed in the future).
final class LoadAppStateEvent extends AppSettingsEvents {}

/// Event to switch between light and dark themes.
final class ToggleThemeEvent extends AppSettingsEvents {
  final bool isDarkMode;

  /// Constructor for theme toggle event.
  /// [isDarkMode] - if true, sets the theme to dark mode, otherwise light mode.
  const ToggleThemeEvent({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
