import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_by_korean/presentation/pages/home_page.dart';
import 'package:bloc_by_korean/features/cubit_bloc_access/bloc_access_page.dart';
import 'package:bloc_by_korean/features/cubit_bloc_access/show_me_counter_page.dart';
import 'package:bloc_by_korean/features/counter/presentation/counter_page.dart';
import 'package:bloc_by_korean/features/counter_depends_on_color/presentation/counter_depends_on_color_page.dart';
import 'package:bloc_by_korean/presentation/pages/theme_page.dart';
import 'package:bloc_by_korean/features/counter/counter_on_cubit/counter_cubit.dart';

import '../../presentation/pages/other_page.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const HomePage());

      case RouteNames.blocAccess:
        return MaterialPageRoute(
          builder: (context) => const BlocAccessPage(),
        );

      case RouteNames.blocAccessCounter:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            // Прокидаємо той самий інстанс, що в BlocAccessPage
            value: BlocProvider.of<CounterOnCubit>(context),
            child: const ShowMeCounter(),
          ),
        );

      case RouteNames.themePage:
        return MaterialPageRoute(builder: (context) => const ThemePage());

      case RouteNames.counterPage:
        return MaterialPageRoute(builder: (context) => const CounterPage());

      case RouteNames.counterDependsOnColor:
        return MaterialPageRoute(
          builder: (context) => const CounterDependsOnColorPage(),
        );

      case RouteNames.otherPage:
        return MaterialPageRoute(
          builder: (context) => const OtherPage(),
        );

      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
