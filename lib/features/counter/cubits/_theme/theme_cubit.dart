import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/presentation/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<CubitThemeState> {
  ThemeCubit() : super(CubitThemeState.initial()) {
    _loadTheme();
  }

  void toggleTheme(bool isDarkMode) async {
    final appTheme = isDarkMode ? AppTheme.dark : AppTheme.light;
    emit(state.copyWith(appTheme: appTheme));
    await _saveTheme(appTheme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final appTheme = isDarkMode ? AppTheme.dark : AppTheme.light;
    emit(state.copyWith(appTheme: appTheme));
  }

  Future<void> _saveTheme(AppTheme appTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', appTheme == AppTheme.dark);
  }
}
