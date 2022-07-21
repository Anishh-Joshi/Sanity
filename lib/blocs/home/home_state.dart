part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final UserInfoModel? user;

  const HomeLoaded({this.user});

  @override
  List<Object> get props => [user!];
}
