import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

/// `AppSettingsOnBloc` handles application settings using the BLoC pattern.
///
/// This BLoC is `Hydrated`, meaning it persists its state locally and restores it on app relaunch.
class AppSettingsOnBloc
    extends HydratedBloc<AppSettingsEvents, AppSettingsStateOnBloc> {
  /// Initializes the BLoC with the initial state and sets up event handlers.
  AppSettingsOnBloc() : super(AppSettingsStateOnBloc.initial()) {
    /// Toggles between BLoC and Cubit state management modes.
    on<ToggleUseBlocEvent>((event, emit) {
      emit(state.copyWith(isUseBloc: !state.isUseBloc));
    });

    /// Toggles the theme between light and dark modes based on the active state management.
    on<ToggleThemeEvent>((event, emit) {
      emit(state.isUseBloc
          ? state.copyWith(isDarkThemeForBloc: event.isDarkMode)
          : state.copyWith(isDarkThemeForCubit: event.isDarkMode));
    });
  }

  /// Persists the current state into a JSON object.
  @override
  Map<String, dynamic>? toJson(AppSettingsStateOnBloc state) => {
        'isUseBloc': state.isUseBloc,
        'isDarkThemeForBloc': state.isDarkThemeForBloc,
        'isDarkThemeForCubit': state.isDarkThemeForCubit,
      };

  /// Restores the state from a JSON object on app startup.
  @override
  AppSettingsStateOnBloc? fromJson(Map<String, dynamic> json) {
    return AppSettingsStateOnBloc(
      isUseBloc: json['isUseBloc'] as bool? ?? true,
      isDarkThemeForBloc: json['isDarkThemeForBloc'] as bool? ?? false,
      isDarkThemeForCubit: json['isDarkThemeForCubit'] as bool? ?? false,
    );
  }
}
