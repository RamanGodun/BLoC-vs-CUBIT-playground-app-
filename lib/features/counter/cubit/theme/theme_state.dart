part of 'theme_cubit.dart';

final class CubitThemeState extends Equatable {
  const CubitThemeState({
    this.appTheme = AppTheme.light,
  });

  factory CubitThemeState.initial() {
    return const CubitThemeState();
  }

  final AppTheme appTheme;

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

  CubitThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return CubitThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
