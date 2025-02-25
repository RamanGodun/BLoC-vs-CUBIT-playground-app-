part of 'theme_bloc.dart';

sealed class ThemeOnBLoCEvent extends Equatable {
  const ThemeOnBLoCEvent();

  @override
  List<Object> get props => [];
}

final class ChangeThemeEvent extends ThemeOnBLoCEvent {
  final bool isDarkMode;

  const ChangeThemeEvent({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];

  @override
  String toString() => 'ChangeThemeEvent(isDarkMode: $isDarkMode)';
}