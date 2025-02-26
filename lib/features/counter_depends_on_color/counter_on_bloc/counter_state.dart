part of 'counter_bloc.dart';

final class CounterStateWhichDependsOnColorBloc extends Equatable {
  const CounterStateWhichDependsOnColorBloc({
    required this.counter,
  });

  factory CounterStateWhichDependsOnColorBloc.initial() {
    return const CounterStateWhichDependsOnColorBloc(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterStateWhichDependsOnColorBloc copyWith({
    int? counter,
  }) {
    return CounterStateWhichDependsOnColorBloc(
      counter: counter ?? this.counter,
    );
  }
}
