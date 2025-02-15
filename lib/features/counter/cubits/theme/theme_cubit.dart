import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/presentation/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<CubitThemeState> {
  ThemeCubit() : super(CubitThemeState.initial());

  void changeTheme(int randInt) {
    if (randInt % 2 == 0) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dark));
    }
  }
}
