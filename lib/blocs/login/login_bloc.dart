import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repo;
  LoginBloc({required this.repo}) : super(LoginLoading()) {
    on<LoginCheck>(_onLoginCheck);
    on<LoginButtonPressed>(_onLoginPressed);
    on<LogoutButtonPressed>(_onLogoutPressed);
    on<SignupButtonPressed>(_onSignupPressed);
    on<AppInformationSkipedPressed>(_onAppinformationSeen);
  }

  void _onLoginCheck(LoginCheck event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    bool tokenData = await repo.hasToken();
    final String isEmailVerified = await repo.checkEmailVerification();
    final bool isAppInfoSeen = await repo.hasAppInformation();

    if (!isAppInfoSeen) {
      emit(InformationNotSeen());
    } else if (tokenData && isEmailVerified == 'verified') {
      emit(LoginAuthenticated());
    } else if (tokenData && isEmailVerified == 'not_verified') {
      emit(LoginEmailNotVerified());
    } else if (isEmailVerified == 'token_error') {
      emit(LoginTokenError());
    } else if (isEmailVerified == "unUnthenticated") {
      emit(LoginUnAuthenticated());
    }
  }

  void _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final authData = await repo.login(event.email, event.password);
      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['access']));
        final String isEmailVerified = await repo.checkEmailVerification();
        if (isEmailVerified == 'verified') {
          emit(LoginAuthenticated());
        } else if (isEmailVerified == 'not_verified') {
          emit(LoginEmailNotVerified());
        } else if (isEmailVerified == 'token_error') {
          emit(LoginTokenError());
        } else if (isEmailVerified == "unUnthenticated") {
          emit(LoginUnAuthenticated());
        }
      } else {
        emit(LoginError(msg: authData['errors']['non_field_errors'][0]));
      }
    } catch (e) {
      emit(LoginError(msg: e.toString()));
    }
  }

  void _onSignupPressed(
      SignupButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final authData =
          await repo.signIn(event.email, event.password, event.confirmPassword);
      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['access']));
        emit(LoginEmailNotVerified());
      } else {
        emit(LoginError(msg: authData['errors']['non_field_errors'][0]));
      }
    } catch (e) {
      emit(LoginError(msg: e.toString()));
    }
  }

  void _onLogoutPressed(
      LogoutButtonPressed event, Emitter<LoginState> emit) async {
    try {
      await repo.deleteToken();
      emit(LoginUnAuthenticated());
    } catch (e) {
      emit(LoginError(msg: e.toString()));
    }
  }

  void _onAppinformationSeen(
      AppInformationSkipedPressed event, Emitter<LoginState> emit) async {
    await repo.persistAppInformation();
    emit(LoginUnAuthenticated());
  }
}
