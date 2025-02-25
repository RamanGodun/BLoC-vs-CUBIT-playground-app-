part of 'counter_bloc.dart';

final class CounterWhichDependsOnColorState extends Equatable {
  const CounterWhichDependsOnColorState({
    required this.counter,
  });

  factory CounterWhichDependsOnColorState.initial() {
    return const CounterWhichDependsOnColorState(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterWhichDependsOnColorState copyWith({
    int? counter,
  }) {
    return CounterWhichDependsOnColorState(
      counter: counter ?? this.counter,
    );
  }
}
