import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_settings_state.dart';

class AppSettingsOnCubit extends HydratedCubit<AppSettingsStateOnCubit> {
  AppSettingsOnCubit() : super(AppSettingsStateOnCubit.initial());

  void toggleUseBloc() {
    final newUseBloc = !state.isUseBloc;
    emit(state.copyWith(isUseBloc: newUseBloc));
  }

  void toggleTheme(bool isDarkMode) {
    if (state.isUseBloc) {
      emit(state.copyWith(isDarkThemeForBloc: isDarkMode));
    } else {
      emit(state.copyWith(isDarkThemeForCubit: isDarkMode));
    }
  }

  @override
  Map<String, dynamic>? toJson(AppSettingsStateOnCubit state) {
    return {
      'isUseBloc': state.isUseBloc,
      'isDarkThemeForBloc': state.isDarkThemeForBloc,
      'isDarkThemeForCubit': state.isDarkThemeForCubit,
    };
  }

  @override
  AppSettingsStateOnCubit? fromJson(Map<String, dynamic> json) {
    return AppSettingsStateOnCubit(
      isUseBloc: json['isUseBloc'] as bool? ?? true,
      isDarkThemeForBloc: json['isDarkThemeForBloc'] as bool? ?? false,
      isDarkThemeForCubit: json['isDarkThemeForCubit'] as bool? ?? false,
    );
  }
}
