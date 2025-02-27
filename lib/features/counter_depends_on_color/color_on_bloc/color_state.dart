part of 'color_bloc.dart';

final class ColorStateOnBLoC extends Equatable {
  const ColorStateOnBLoC({
    required this.color,
  });

  factory ColorStateOnBLoC.initial() {
    return const ColorStateOnBLoC(color: Colors.red);
  }

  final Color color;

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'ColorState(color: $color)';

  ColorStateOnBLoC copyWith({
    Color? color,
  }) {
    return ColorStateOnBLoC(
      color: color ?? this.color,
    );
  }
}
