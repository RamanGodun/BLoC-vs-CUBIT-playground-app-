import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/presentation/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeOnBloc extends Bloc<ThemeOnBLoCEvent, ThemeOnBLoCState> {
  ThemeOnBloc() : super(ThemeOnBLoCState.initial()) {
    _loadTheme();

    on<ChangeThemeEvent>((event, emit) async {
      final appTheme = event.isDarkMode ? AppTheme.dark : AppTheme.light;
      emit(state.copyWith(appTheme: appTheme));
      await _saveTheme(appTheme);
    });
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    // final appTheme = isDarkMode ? AppTheme.dark : AppTheme.light;
    add(ChangeThemeEvent(isDarkMode: isDarkMode));
  }

  Future<void> _saveTheme(AppTheme appTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', appTheme == AppTheme.dark);
  }
}
