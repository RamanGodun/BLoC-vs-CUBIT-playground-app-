// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppConfigService extends ChangeNotifier {
//   bool _useBloc = true;

//   bool get useBloc => _useBloc;

//   AppConfigService() {
//     loadUseBlocPreference();
//   }

//   Future<void> loadUseBlocPreference() async {
//     final prefs = await SharedPreferences.getInstance();
//     _useBloc = prefs.getBool('useBloc') ?? true;
//     notifyListeners();
//   }

//   Future<void> toggleBlocUsage() async {
//     _useBloc = !_useBloc;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('useBloc', _useBloc);
//     notifyListeners();
//   }

//   Future<void> setUseBloc(bool value) async {
//     _useBloc = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('useBloc', value);
//     notifyListeners();
//   }
// }
