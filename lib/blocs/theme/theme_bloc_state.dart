part of 'theme_bloc_bloc.dart';

abstract class ThemeBlocState extends Equatable {
  const ThemeBlocState();

  @override
  List<Object> get props => [];
}

class ThemeBlocInitial extends ThemeBlocState {}

class ThemeDataBloc extends ThemeBlocState {
  final bool isDark;

  const ThemeDataBloc({required this.isDark});
  @override
  List<Object> get props => [isDark];
}
