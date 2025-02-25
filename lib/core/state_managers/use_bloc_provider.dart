import 'package:flutter/material.dart';

class UseBlocProvider extends InheritedWidget {
  final bool useBloc;
  final VoidCallback toggleUseBloc;

  const UseBlocProvider({
    super.key,
    required this.useBloc,
    required this.toggleUseBloc,
    required super.child,
  });

  static UseBlocProvider of(BuildContext context) {
    final UseBlocProvider? result =
        context.dependOnInheritedWidgetOfExactType<UseBlocProvider>();
    assert(result != null, 'No UseBlocProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UseBlocProvider oldWidget) =>
      useBloc != oldWidget.useBloc;
}
