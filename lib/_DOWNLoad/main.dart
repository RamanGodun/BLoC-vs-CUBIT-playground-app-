import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/counter/blocs/color/color_bloc.dart';
import '../features/counter/blocs/counter_which_depends_on_color/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorOnBloc>(
          create: (context) => ColorOnBloc(),
        ),
        BlocProvider<CounterBlocWhichDependsOnColorBLoC>(
          create: (context) => CounterBlocWhichDependsOnColorBLoC(
            colorBloc: context.read<ColorOnBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'bloc2bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorOnBloc>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ColorOnBloc>().add(ChangeColorEvent());
              },
              child: const Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              '${context.watch<CounterBlocWhichDependsOnColorBLoC>().state.counter}',
              style: const TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CounterBlocWhichDependsOnColorBLoC>()
                    .add(ChangeCounterEvent());
              },
              child: const Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
