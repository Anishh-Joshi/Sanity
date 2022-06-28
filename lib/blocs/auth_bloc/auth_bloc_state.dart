part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthBlocLoading extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthLoaded extends AuthBlocState {}

class LoginErrorState extends AuthBlocState {
  final String message;

  const LoginErrorState({required this.message});
}
