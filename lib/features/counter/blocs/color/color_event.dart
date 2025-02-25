part of 'color_bloc.dart';

sealed class ColorOnBLoCEvent extends Equatable {
  const ColorOnBLoCEvent();

  @override
  List<Object> get props => [];
}

final class ChangeColorEvent extends ColorOnBLoCEvent {}
