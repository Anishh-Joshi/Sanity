part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCheck extends LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignupButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const SignupButtonPressed(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object> get props => [email, password,confirmPassword];
}


class ChangePassword extends LoginEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const ChangePassword(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object> get props => [email, password,confirmPassword];
}

class LogoutButtonPressed extends LoginEvent {}

class BackToLoginPage extends LoginEvent {}

class LoginCheckEmailVerification extends LoginEvent {}

class AppInformationSkipedPressed extends LoginEvent {}
