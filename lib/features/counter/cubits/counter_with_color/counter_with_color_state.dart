part of 'counter_with_color_cubit.dart';

final class CounterWithColorState extends Equatable {
  const CounterWithColorState({
    required this.counter,
  });

  factory CounterWithColorState.initial() {
    return const CounterWithColorState(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterWithColorState copyWith({
    int? counter,
  }) {
    return CounterWithColorState(
      counter: counter ?? this.counter,
    );
  }
}
