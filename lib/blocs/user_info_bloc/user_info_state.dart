part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object?> get props => [];
}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {}

class UserInfoError extends UserInfoState {
  final String msg;

  const UserInfoError({required this.msg});
  @override
  List<Object> get props => [msg];
}
