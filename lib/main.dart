import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/presentation/constants.dart';
import 'features/counter_cubit/counter_cubit.dart';
import 'features/counter_cubit/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'BLoC or Cubit',
        debugShowCheckedModeBanner: false,
        theme: UIConstants.appTheme,
        home: const MyHomePage(),
      ),
    );
  }
}
