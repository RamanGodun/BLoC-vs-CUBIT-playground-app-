import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/widgets/text_widget.dart';
import '../counter/counter_on_cubit/counter_cubit.dart';

class ShowMeCounter extends StatelessWidget {
  const ShowMeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Counter', TextType.titleMedium),
      ),
      body: Center(
        child: BlocBuilder<CounterOnCubit, CounterOnCubitState>(
          builder: (context, state) {
            return TextWidget('${state.counter}', TextType.headline);
          },
        ),
      ),
    );
  }
}
