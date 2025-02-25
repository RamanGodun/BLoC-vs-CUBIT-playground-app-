part of 'counter_bloc.dart';

sealed class CounterWhichDependsOnColorEvent extends Equatable {
  const CounterWhichDependsOnColorEvent();

  @override
  List<Object> get props => [];
}

final class ChangeCounterEvent extends CounterWhichDependsOnColorEvent {}
