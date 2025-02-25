part of 'theme_bloc.dart';

sealed class ThemeOnBLoCEvent extends Equatable {
  const ThemeOnBLoCEvent();

  @override
  List<Object> get props => [];
}

final class ChangeThemeEvent extends ThemeOnBLoCEvent {
  const ChangeThemeEvent({
    required this.randInt,
  });

  final int randInt;

  @override
  String toString() => 'ChangeThemeEvent(randInt: $randInt)';

  @override
  List<Object> get props => [randInt];
}
