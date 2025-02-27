part of 'color_bloc.dart';

sealed class ColorEvents extends Equatable {
  const ColorEvents();

  @override
  List<Object> get props => [];
}

final class ChangeColorEvent extends ColorEvents {}
