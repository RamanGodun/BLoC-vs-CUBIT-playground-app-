import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../color_on_cubit/color_cubit.dart';

part 'counter_which_depends_on_color_state.dart';

class CounterCubitWhichDependsOnColorCubit
    extends Cubit<CounterCubitStateWhichDependsOnColorCubit> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  late final StreamSubscription colorSubscription;

  CounterCubitWhichDependsOnColorCubit({
    required this.colorCubit,
  }) : super(CounterCubitStateWhichDependsOnColorCubit.initial()) {
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
