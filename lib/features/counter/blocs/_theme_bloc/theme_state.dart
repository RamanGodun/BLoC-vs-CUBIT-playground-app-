part of 'theme_bloc.dart';

final class ThemeOnBLoCState extends Equatable {
  final AppTheme appTheme;

  const ThemeOnBLoCState({this.appTheme = AppTheme.light});

  factory ThemeOnBLoCState.initial() => const ThemeOnBLoCState();

  ThemeOnBLoCState copyWith({AppTheme? appTheme}) {
    return ThemeOnBLoCState(appTheme: appTheme ?? this.appTheme);
  }

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeOnBLoCState(appTheme: $appTheme)';
}
