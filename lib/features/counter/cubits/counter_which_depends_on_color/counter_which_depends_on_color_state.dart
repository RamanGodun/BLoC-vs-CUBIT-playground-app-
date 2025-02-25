part of 'counter_which_depends_on_color_cubit.dart';

final class CounterCubitWhichDependsOnColorCubitState extends Equatable {
  const CounterCubitWhichDependsOnColorCubitState({
    required this.counter,
  });

  factory CounterCubitWhichDependsOnColorCubitState.initial() {
    return const CounterCubitWhichDependsOnColorCubitState(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterCubitWhichDependsOnColorCubitState copyWith({int? counter}) {
    return CounterCubitWhichDependsOnColorCubitState(
      counter: counter ?? this.counter,
    );
  }
}
