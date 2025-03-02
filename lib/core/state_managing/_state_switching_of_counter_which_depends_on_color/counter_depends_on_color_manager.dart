import 'package:flutter/material.dart';
import '../../../features/counter_depends_on_color/counter_on_bloc/counter_bloc.dart';
import '../../../features/counter_depends_on_color/color_on_bloc/color_bloc.dart';
import '../../../features/counter_depends_on_color/counter_on_cubit/counter_which_depends_on_color_cubit.dart';
import '../../../features/counter_depends_on_color/color_on_cubit/color_cubit.dart';

abstract class CounterDependsOnColorManager extends ChangeNotifier {
  int get currentCounter;
  ValueNotifier<Color> backgroundColor = ValueNotifier<Color>(Colors.white);

  void changeCounter();
  void changeColor();
}

class BlocCounterDependsOnColorManager extends CounterDependsOnColorManager {
  final CounterBlocWhichDependsOnColorBLoC _counterBloc;
  final ColorOnBloc _colorBloc;

  BlocCounterDependsOnColorManager(this._counterBloc, this._colorBloc) {
    _colorBloc.stream.listen((colorState) {
      backgroundColor.value = colorState.color;
      notifyListeners();
    });
  }

  @override
  int get currentCounter => _counterBloc.state.counter;

  @override
  void changeCounter() {
    print('changeCounter() called in BlocCounterDependsOnColorManager');
    _counterBloc.add(ChangeCounterEvent());
  }

  @override
  void changeColor() => _colorBloc.add(ChangeColorEvent());
}

class CubitCounterDependsOnColorManager extends CounterDependsOnColorManager {
  final CounterCubitWhichDependsOnColorCubit _counterCubit;
  final ColorOnCubit _colorCubit;

  CubitCounterDependsOnColorManager(
    this._counterCubit,
    this._colorCubit,
  ) {
    _colorCubit.stream.listen((colorState) {
      backgroundColor.value = colorState.color;
      notifyListeners();
    });
  }

  @override
  int get currentCounter => _counterCubit.state.counter;

  @override
  void changeCounter() {
    print('changeCounter() called in CubitCounterDependsOnColorManager');
    _counterCubit.changeCounter();
  }

  @override
  void changeColor() => _colorCubit.changeColor();
}
