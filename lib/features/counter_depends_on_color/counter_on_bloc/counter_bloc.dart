import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../color_on_bloc/color_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBlocWhichDependsOnColorBLoC extends Bloc<
    CounterEventWhichDependsOnColorBloc, CounterStateWhichDependsOnColorBloc> {
  int incrementSize = 1;
  final ColorOnBloc colorBloc;
  late final StreamSubscription colorSubscription;

  CounterBlocWhichDependsOnColorBLoC({
    required this.colorBloc,
  }) : super(CounterStateWhichDependsOnColorBloc.initial()) {
    colorSubscription = colorBloc.stream.listen((ColorOnBLoCState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        incrementSize = -100;
        add(ChangeCounterEvent());
      }
    });

    on<ChangeCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + incrementSize));
    });
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
