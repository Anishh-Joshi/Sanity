part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateHomeInfo extends HomeEvent {
  final UserInfoModel? user;

  const UpdateHomeInfo({this.user});

  @override
  List<Object> get props => [user!];
}
