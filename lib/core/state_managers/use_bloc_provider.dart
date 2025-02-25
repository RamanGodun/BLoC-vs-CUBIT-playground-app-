import 'package:flutter/material.dart';

class UseBlocProvider extends ChangeNotifier {
  bool _useBloc = true;

  bool get useBloc => _useBloc;

  void toggleUseBloc() {
    _useBloc = !_useBloc;
    notifyListeners();
  }
}
