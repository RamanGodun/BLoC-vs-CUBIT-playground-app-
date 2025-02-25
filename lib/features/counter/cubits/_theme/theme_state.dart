part of 'theme_cubit.dart';

final class CubitThemeState extends Equatable {
  final AppTheme appTheme;

  const CubitThemeState({this.appTheme = AppTheme.light});

  factory CubitThemeState.initial() => const CubitThemeState();

  CubitThemeState copyWith({AppTheme? appTheme}) {
    return CubitThemeState(appTheme: appTheme ?? this.appTheme);
  }

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'CubitThemeState(appTheme: $appTheme)';
}
