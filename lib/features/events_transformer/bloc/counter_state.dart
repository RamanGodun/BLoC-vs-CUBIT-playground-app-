part of 'counter_bloc.dart';

final class CounterStateWithTransformers extends Equatable {
  const CounterStateWithTransformers({
    required this.counter,
  });

  factory CounterStateWithTransformers.initial() {
    return const CounterStateWithTransformers(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterStateWithTransformers copyWith({
    int? counter,
  }) {
    return CounterStateWithTransformers(
      counter: counter ?? this.counter,
    );
  }
}
