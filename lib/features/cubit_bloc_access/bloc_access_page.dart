import 'package:bloc_by_korean/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/route_names.dart';
import '../../core/utils/helpers.dart';
import '../counter/counter_on_cubit/counter_cubit.dart';

class BlocAccessPage extends StatelessWidget {
  const BlocAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Helpers.pushNamed(context, RouteNames.blocAccessCounter),
              child: const TextWidget('Show Me Counter', TextType.button),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.read<CounterOnCubit>().increment(),
              child:
                  const TextWidget('Increment Counter', TextType.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}
