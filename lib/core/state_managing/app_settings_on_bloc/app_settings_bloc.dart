import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsOnBloc
    extends HydratedBloc<AppSettingsEvents, AppSettingsStateOnBloc> {
  AppSettingsOnBloc() : super(AppSettingsStateOnBloc.initial()) {
    on<ToggleUseBlocEvent>((event, emit) {
      final newUseBloc = !state.isUseBloc;
      emit(state.copyWith(isUseBloc: newUseBloc));
    });

    on<ToggleThemeEvent>((event, emit) {
      if (state.isUseBloc) {
        emit(state.copyWith(isDarkThemeForBloc: event.isDarkMode));
      } else {
        emit(state.copyWith(isDarkThemeForCubit: event.isDarkMode));
      }
    });
  }

  /// Метод для збереження стану у локальне сховище
  @override
  Map<String, dynamic>? toJson(AppSettingsStateOnBloc state) {
    return {
      'isUseBloc': state.isUseBloc,
      'isDarkThemeForBloc': state.isDarkThemeForBloc,
      'isDarkThemeForCubit': state.isDarkThemeForCubit,
    };
  }

  /// Метод для відновлення стану при старті програми
  @override
  AppSettingsStateOnBloc? fromJson(Map<String, dynamic> json) {
    return AppSettingsStateOnBloc(
      isUseBloc: json['isUseBloc'] as bool? ?? true,
      isDarkThemeForBloc: json['isDarkThemeForBloc'] as bool? ?? false,
      isDarkThemeForCubit: json['isDarkThemeForCubit'] as bool? ?? false,
    );
  }
}
