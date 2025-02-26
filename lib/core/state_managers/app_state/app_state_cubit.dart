import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppStateCubit extends Cubit<AppState> {
  final SharedPreferences _prefs;

  AppStateCubit(this._prefs) : super(AppState.initial()) {
    _loadState();
  }

  Future<void> _loadState() async {
    final isUseBloc = _prefs.getBool('isUseBloc') ?? true;
    final isDarkThemeForBloc = _prefs.getBool('isDarkModeBloc') ?? false;
    final isDarkThemeForCubit = _prefs.getBool('isDarkModeCubit') ?? false;

    emit(state.copyWith(
      isUseBloc: isUseBloc,
      isDarkThemeForBloc: isDarkThemeForBloc,
      isDarkThemeForCubit: isDarkThemeForCubit,
    ));
  }

  Future<void> toggleUseBloc() async {
    final newUseBloc = !state.isUseBloc;
    await _prefs.setBool('isUseBloc', newUseBloc);
    emit(state.copyWith(isUseBloc: newUseBloc));
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    if (state.isUseBloc) {
      await _prefs.setBool('isDarkModeBloc', isDarkMode);
      emit(state.copyWith(isDarkThemeForBloc: isDarkMode));
    } else {
      await _prefs.setBool('isDarkModeCubit', isDarkMode);
      emit(state.copyWith(isDarkThemeForCubit: isDarkMode));
    }
  }
}