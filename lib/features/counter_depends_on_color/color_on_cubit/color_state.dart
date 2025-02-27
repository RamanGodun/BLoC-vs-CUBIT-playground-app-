part of 'color_cubit.dart';

final class ColorStateOnCubit extends Equatable {
  const ColorStateOnCubit({
    required this.color,
  });

  factory ColorStateOnCubit.initial() {
    return const ColorStateOnCubit(color: Colors.red);
  }

  final Color color;

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'ColorState(color: $color)';

  ColorStateOnCubit copyWith({
    Color? color,
  }) {
    return ColorStateOnCubit(
      color: color ?? this.color,
    );
  }
}
