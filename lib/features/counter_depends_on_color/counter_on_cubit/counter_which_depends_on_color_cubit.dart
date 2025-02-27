import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../color_on_cubit/color_cubit.dart';

part 'counter_which_depends_on_color_state.dart';

class CounterCubitWhichDependsOnColorCubit
    extends Cubit<CounterCubitStateWhichDependsOnColorCubit> {
  int incrementSize = 1;
  final ColorOnCubit colorCubit;
  late final StreamSubscription colorSubscription;

  CounterCubitWhichDependsOnColorCubit({
    required this.colorCubit,
  }) : super(CounterCubitStateWhichDependsOnColorCubit.initial()) {
    //
    colorSubscription =
        colorCubit.stream.listen((ColorStateOnCubit colorState) {
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
          incrementSize = -100;
          emit(state.copyWith(counter: state.counter - 100));
        default:
          incrementSize = 1;
      }

      print(
          '[Cubit] Color Changed to ${colorState.color}, New Increment Size: $incrementSize');
    });
    //
  }

  void changeCounter() {
    final newCounter = state.counter + incrementSize;
    print(
        '[Cubit] ChangeCounter called - New Counter: $newCounter, Increment Size: $incrementSize');
    emit(state.copyWith(counter: newCounter));
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
