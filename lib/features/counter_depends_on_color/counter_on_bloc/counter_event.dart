part of 'counter_bloc.dart';

sealed class CounterEventWhichDependsOnColorBloc extends Equatable {
  const CounterEventWhichDependsOnColorBloc();

  @override
  List<Object> get props => [];
}

final class ChangeCounterEvent extends CounterEventWhichDependsOnColorBloc {}
