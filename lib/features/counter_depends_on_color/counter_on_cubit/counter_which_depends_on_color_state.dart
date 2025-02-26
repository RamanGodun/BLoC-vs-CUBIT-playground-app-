part of 'counter_which_depends_on_color_cubit.dart';

final class CounterCubitStateWhichDependsOnColorCubit extends Equatable {
  const CounterCubitStateWhichDependsOnColorCubit({
    required this.counter,
  });

  factory CounterCubitStateWhichDependsOnColorCubit.initial() {
    return const CounterCubitStateWhichDependsOnColorCubit(counter: 0);
  }

  final int counter;

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterCubitStateWhichDependsOnColorCubit copyWith({int? counter}) {
    return CounterCubitStateWhichDependsOnColorCubit(
      counter: counter ?? this.counter,
    );
  }
}
