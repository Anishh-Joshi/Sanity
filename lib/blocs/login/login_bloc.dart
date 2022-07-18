import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/auth_repo.dart';

import '../../model/user_class.dart';

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
    on<BackToLoginPage>(_backToLoginPage);
  }

  void _onLoginCheck(LoginCheck event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    bool tokenData = await repo.hasToken();
    final Map profileData = await repo.getProfileData();
    final bool isAppInfoSeen = await repo.hasAppInformation();

    if (!isAppInfoSeen) {
      emit(InformationNotSeen());
    } else if (tokenData && profileData['is_email_verified']) {
      //check if user is registered or not
      emit(LoginAuthenticated(
          email: profileData['email'],
          id: profileData['id'],
          isEmailVerified: profileData['is_email_verified']));
    } else if (tokenData && !profileData['is_email_verified']) {
      //check if registered user or not
      emit(LoginEmailNotVerified(
          email: profileData['email'],
          id: profileData['id'],
          isEmailVerified: profileData['is_email_verified']));
    } else if (profileData['errors']["details"] != null) {
      emit(LoginTokenError());
    } else if (!tokenData) {
      emit(LoginUnAuthenticated());
    }
  }

  void _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      bool tokenData = await repo.hasToken();
      final authData = await repo.login(event.email, event.password);

      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['access']));
        final Map profileData = await repo.getProfileData();
        if (profileData['is_email_verified']) {
          emit(LoginAuthenticated(
              email: profileData['email'],
              id: profileData['id'],
              isEmailVerified: profileData['is_email_verified']));
        } else if (!profileData['is_email_verified']) {
          emit(LoginEmailNotVerified(
              email: profileData['email'],
              id: profileData['id'],
              isEmailVerified: profileData['is_email_verified']));
        } else if (profileData['errors']["details"] != null) {
          emit(LoginTokenError());
        } else if (!tokenData) {
          emit(LoginUnAuthenticated());
        }
      } else {
        emit(LoginError(msg: authData['errors']['non_field_errors'][0]));
      }
    } catch (e) {
      emit(LoginError(msg: e.toString()));
    }
  }

  void _backToLoginPage(BackToLoginPage event, Emitter<LoginState> emit) async {
    emit(LoginUnAuthenticated());
  }

  void _onSignupPressed(
      SignupButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final authData =
          await repo.signIn(event.email, event.password, event.confirmPassword);
      final Map profileData = await repo.getProfileData();
      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['access']));
        emit(LoginEmailNotVerified(
            email: profileData['email'],
            id: profileData['id'],
            isEmailVerified: profileData['is_email_verified']));
      } else if (authData['errors'] != null) {
        emit(LoginError(msg: authData['errors']['non_field_errors'][0]));
      }
    } catch (e) {
      final authData =
          await repo.signIn(event.email, event.password, event.confirmPassword);
      print(authData);
      emit(LoginError(msg: authData['errors']['email'][0]));
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
