import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBloc() : super(const ThemeBlocState(isDark: false)) {
    on<ChangeTheme>(_changeAppTheme);
    on<LoadTheme>(_loadTheme);
  }

  void _changeAppTheme(ChangeTheme event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    bool? themeData = prefs.getBool('isDark');
    await prefs.setBool("isDark", !themeData!);
    final theme =  prefs.getBool('isDark');
    if (theme!) {
      emit(const ThemeBlocState(isDark: true));
    } else {
      emit(const ThemeBlocState(isDark: false));
    }

  }

  void _loadTheme(LoadTheme event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    bool? hasThemeDark = prefs.getBool('isDark');
    if (hasThemeDark == null) {
      await prefs.setBool("isDark", false);
    }
    bool? theme = prefs.getBool('isDark');
    if (theme!) {
      emit(const ThemeBlocState(isDark: true));
    } else {
      emit(const ThemeBlocState(isDark: false));
    }
  }
}
