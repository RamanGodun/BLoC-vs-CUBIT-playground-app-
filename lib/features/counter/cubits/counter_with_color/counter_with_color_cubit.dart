import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../color/color_cubit.dart';

part 'counter_with_color_state.dart';

class CounterWithColorCubit extends Cubit<CounterWithColorState> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  late final StreamSubscription colorSubscription;

  CounterWithColorCubit({
    required this.colorCubit,
  }) : super(CounterWithColorState.initial()) {
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
      switch (colorState.color) {
        case Colors.red:
          incrementSize = 1;
          break;
        case Colors.green:
          incrementSize = 10;
          break;
        case Colors.blue:
          incrementSize = 100;
          break;
        case Colors.black:
          emit(state.copyWith(counter: state.counter - 100));
          incrementSize = -100;
          break;
        default:
          incrementSize = 1;
      }
    });
  }

  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
