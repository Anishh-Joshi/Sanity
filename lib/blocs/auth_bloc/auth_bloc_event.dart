part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthBlocEvent {}

class LoginPressed extends AuthBlocEvent {
  final String email;
  final String pasword;

  const LoginPressed(this.email, this.pasword);
}
