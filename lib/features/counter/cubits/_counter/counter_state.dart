part of 'counter_cubit.dart';

final class CounterOnCubitState extends Equatable {
  const CounterOnCubitState({
    required this.counter,
  });

  factory CounterOnCubitState.initial() {
    return const CounterOnCubitState(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterOnCubitState copyWith({
    int? counter,
  }) {
    return CounterOnCubitState(
      counter: counter ?? this.counter,
    );
  }
}
