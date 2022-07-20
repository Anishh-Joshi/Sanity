import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBloc() : super(ThemeBlocInitial()) {
    on<ChangeTheme>(_changeAppTheme);
    on<LoadTheme>(_loadTheme);
  }

  void _changeAppTheme(ChangeTheme event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    final themeData = prefs.getBool('isDark');
    await prefs.setBool("isDark", !themeData!);
    final theme = prefs.getBool('isDark');

    if (theme!) {
      emit(const ThemeDataBloc(isDark: true));
    } else {
      emit(const ThemeDataBloc(isDark: false));
    }
  }

  void _loadTheme(LoadTheme event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    final hasThemeDark = prefs.getBool('isDark');
    if (hasThemeDark == null) {
      await prefs.setBool("isDark", false);
    }
    final theme = prefs.getBool('isDark');
    if (theme!) {
      emit(const ThemeDataBloc(isDark: false));
    } else {
      emit(const ThemeDataBloc(isDark: false));
    }
  }
}
