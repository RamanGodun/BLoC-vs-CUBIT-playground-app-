/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/bloc_access/bloc_access_page.dart';
import '../../features/counter/counter_on_cubit/counter_cubit.dart';
import 'show_me_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterOnCubit _counterCubit = CounterOnCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _counterCubit,
                child: const BlocAccessPage(),
              ),
            );
          case '/counter':
            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _counterCubit,
                child: const ShowMeCounter(),
              ),
            );
          default:
            return null;
        }
      },
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}


 */
