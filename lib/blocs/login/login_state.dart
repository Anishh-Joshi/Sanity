part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {
  final String email;
  final bool isEmailVerified;
  final int id;

  const LoginAuthenticated(
      {required this.email, required this.isEmailVerified, required this.id});
  @override
  List<Object> get props => [email, id, isEmailVerified];
}

class LoginUnAuthenticated extends LoginState {}

class LoginEmailNotVerified extends LoginState {
  final String email;
  final bool isEmailVerified;
  final int id;

  const LoginEmailNotVerified(
      {required this.email, required this.isEmailVerified, required this.id});
  @override
  List<Object> get props => [email, id, isEmailVerified];
}

class LoginTokenError extends LoginState {}

class SignInAuthenticated extends LoginState {
  final String email;
  final bool isEmailVerified;
  final int id;

  const SignInAuthenticated(
      {required this.email, required this.isEmailVerified, required this.id});
  @override
  List<Object> get props => [email, id, isEmailVerified];
}

class InformationNotSeen extends LoginState {}

class RegisteredUser extends LoginState {}

class UnRegisteredUser extends LoginState {}

class LoginError extends LoginState {
  final String msg;

  const LoginError({required this.msg});
  @override
  List<Object> get props => [msg];
}
