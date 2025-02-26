import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsOnBloc
    extends Bloc<AppSettingsEvents, AppSettingsStateOnBloc> {
  final SharedPreferences _prefs;

  AppSettingsOnBloc(this._prefs) : super(AppSettingsStateOnBloc.initial()) {
    on<LoadAppStateEvent>((event, emit) async {
      final isUseBloc = _prefs.getBool('isUseBloc') ?? true;
      final isDarkThemeForBloc = _prefs.getBool('isDarkModeBloc') ?? false;
      final isDarkThemeForCubit = _prefs.getBool('isDarkModeCubit') ?? false;

      emit(state.copyWith(
        isUseBloc: isUseBloc,
        isDarkThemeForBloc: isDarkThemeForBloc,
        isDarkThemeForCubit: isDarkThemeForCubit,
      ));
    });

    on<ToggleUseBlocEvent>((event, emit) async {
      final newUseBloc = !state.isUseBloc;
      await _prefs.setBool('isUseBloc', newUseBloc);
      emit(state.copyWith(isUseBloc: newUseBloc));
    });

    on<ToggleThemeEvent>((event, emit) async {
      if (state.isUseBloc) {
        await _prefs.setBool('isDarkModeBloc', event.isDarkMode);
        emit(state.copyWith(isDarkThemeForBloc: event.isDarkMode));
      } else {
        await _prefs.setBool('isDarkModeCubit', event.isDarkMode);
        emit(state.copyWith(isDarkThemeForCubit: event.isDarkMode));
      }
    });

    // Викликаємо `LoadAppStateEvent` ПІСЛЯ перезапуску
    add(LoadAppStateEvent());
  }
}
