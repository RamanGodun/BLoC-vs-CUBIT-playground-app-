import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/presentation/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeOnBloc extends Bloc<ThemeOnBLoCEvent, ThemeOnBLoCState> {
  ThemeOnBloc() : super(ThemeOnBLoCState.initial()) {
    on<ChangeThemeEvent>((event, emit) {
      if (event.randInt % 2 == 0) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
    });
  }
}
