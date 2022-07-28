part of 'theme_bloc_bloc.dart';

class ThemeBlocState extends Equatable {
   final bool isDark;

  const ThemeBlocState({required this.isDark});
  @override
  List<Object> get props => [isDark];
}

