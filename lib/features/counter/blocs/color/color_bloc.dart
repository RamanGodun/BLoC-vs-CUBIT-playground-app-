import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorOnBloc extends Bloc<ColorOnBLoCEvent, ColorOnBLoCState> {
  ColorOnBloc() : super(ColorOnBLoCState.initial()) {
    on<ChangeColorEvent>(_changeColor);
  }

  void _changeColor(ChangeColorEvent event, Emitter<ColorOnBLoCState> emit) {
    if (state.color == Colors.red) {
      emit(state.copyWith(color: Colors.green));
    } else if (state.color == Colors.green) {
      emit(state.copyWith(color: Colors.blue));
    } else if (state.color == Colors.blue) {
      emit(state.copyWith(color: Colors.black));
    } else if (state.color == Colors.black) {
      emit(state.copyWith(color: Colors.red));
    }
  }
}
