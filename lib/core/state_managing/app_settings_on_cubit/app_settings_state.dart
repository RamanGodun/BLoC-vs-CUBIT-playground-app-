part of 'app_settings_cubit.dart';

/// Represents the state for application settings managed by [AppSettingsOnCubit].
/// It includes whether the app is using BLoC or Cubit, and the theme settings for both approaches.
class AppSettingsStateOnCubit extends Equatable {
  /// Indicates whether the app uses BLoC or Cubit state management.
  final bool isUseBloc;

  /// Stores the dark theme preference when using BLoC or Cubit
  final bool isDarkThemeForBloc;
  final bool isDarkThemeForCubit;

  const AppSettingsStateOnCubit({
    required this.isUseBloc,
    required this.isDarkThemeForBloc,
    required this.isDarkThemeForCubit,
  });

  /// Returns the initial state with default values.
  /// Defaults to BLoC as the state management approach with light themes.
  factory AppSettingsStateOnCubit.initial() {
    return const AppSettingsStateOnCubit(
      isUseBloc: true,
      isDarkThemeForBloc: false,
      isDarkThemeForCubit: false,
    );
  }

  /// Creates a new state instance with the option to override specific values.
  /// This method maintains immutability by returning a new instance instead of modifying the existing state.
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

  /// Properties used for equality checks to ensure proper state comparison.
  @override
  List<Object> get props =>
      [isUseBloc, isDarkThemeForBloc, isDarkThemeForCubit];
}
