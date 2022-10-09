part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {
  final UserInfoModel user;
  final User userBase;

  const LoginAuthenticated({required this.userBase,required this.user});

  @override
  List<Object> get props => [user];
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

class UnRegisteredUser extends LoginState {
  final String email;
  final bool isEmailVerified;
  final int id;
  const UnRegisteredUser(
      {required this.email, required this.isEmailVerified, required this.id});
  @override
  List<Object> get props => [email, id, isEmailVerified];
}

class LoginError extends LoginState {
  final String msg;

  const LoginError({required this.msg});
  @override
  List<Object> get props => [msg];
}
