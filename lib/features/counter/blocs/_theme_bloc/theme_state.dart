part of 'theme_bloc.dart';

final class ThemeOnBLoCState extends Equatable {
  const ThemeOnBLoCState({
    this.appTheme = AppTheme.light,
  });

  factory ThemeOnBLoCState.initial() {
    return const ThemeOnBLoCState();
  }

  final AppTheme appTheme;

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

  ThemeOnBLoCState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeOnBLoCState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
