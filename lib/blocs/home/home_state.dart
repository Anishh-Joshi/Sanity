part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final UserInfoModel? user;
  final User? baseUser ;

  const HomeLoaded({this.user, this.baseUser});

  @override
  List<Object> get props => [user!,baseUser!];
}
