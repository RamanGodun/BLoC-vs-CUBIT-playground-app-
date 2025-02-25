import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'use_bloc_provider.dart';

class UseBlocWrapper extends StatefulWidget {
  final Widget child;

  const UseBlocWrapper({super.key, required this.child});

  @override
  State<UseBlocWrapper> createState() => _UseBlocWrapperState();
}

class _UseBlocWrapperState extends State<UseBlocWrapper> {
  bool useBloc = true;

  @override
  void initState() {
    super.initState();
    _loadUseBlocPreference();
  }

  Future<void> _loadUseBlocPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      useBloc = prefs.getBool('useBloc') ?? true;
    });
  }

  Future<void> _toggleUseBloc() async {
    setState(() {
      useBloc = !useBloc;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useBloc', useBloc);
  }

  @override
  Widget build(BuildContext context) {
    return UseBlocProvider(
      useBloc: useBloc,
      toggleUseBloc: _toggleUseBloc,
      child: widget.child,
    );
  }
}
