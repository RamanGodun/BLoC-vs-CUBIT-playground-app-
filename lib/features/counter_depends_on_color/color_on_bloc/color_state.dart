part of 'color_bloc.dart';

final class ColorOnBLoCState extends Equatable {
  const ColorOnBLoCState({
    required this.color,
  });

  factory ColorOnBLoCState.initial() {
    return const ColorOnBLoCState(color: Colors.red);
  }

  final Color color;

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'ColorState(color: $color)';

  ColorOnBLoCState copyWith({
    Color? color,
  }) {
    return ColorOnBLoCState(
      color: color ?? this.color,
    );
  }
}
