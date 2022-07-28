import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/user_info_model.dart';
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
    if (!tokenData) {
      emit(LoginUnAuthenticated());
    }
    await loginCheck(emit, tokenData);
  }

  void _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      bool tokenData = await repo.hasToken();
      final authData = await repo.login(event.email, event.password);

      if (authData["token"] != null) {
        await repo.persistToken((authData["token"]['access']));
        final Map profileData = await repo.getProfileData();
        final User userModel = User.fromJson(profileData);
        if (userModel.isEmailVerified!) {
          final Map userInfoMap =
              await repo.registeredProfileData(id: userModel.id!);
          if (userInfoMap['status'] == "success") {
            final UserInfoModel user =
                UserInfoModel.fromJson(userInfoMap['candidates']);
            emit(LoginAuthenticated(user: user));
          } else {
            emit(UnRegisteredUser(
                email: userModel.email!,
                id: userModel.id!,
                isEmailVerified: userModel.isEmailVerified!));
          }
        } else if (!userModel.isEmailVerified!) {
          emit(LoginEmailNotVerified(
              email: userModel.email!,
              id: userModel.id!,
              isEmailVerified: userModel.isEmailVerified!));
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

      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['access']));
        final Map profileData = await repo.getProfileData();
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

  Future<void> loginCheck(Emitter<LoginState> emit, bool tokenData) async {
    final Map profileData = await repo.getProfileData();
    final bool isAppInfoSeen = await repo.hasAppInformation();
    final User userModel = User.fromJson(profileData);

    if (!isAppInfoSeen) {
      emit(InformationNotSeen());
    } else if (isAppInfoSeen && tokenData && userModel.isEmailVerified!) {
      final Map userInfoMap =
          await repo.registeredProfileData(id: userModel.id!);
      if (userInfoMap['status'] == "success") {
        final UserInfoModel user =
            UserInfoModel.fromJson(userInfoMap['candidates']);

        emit(LoginAuthenticated(user: user));
      } else {
        emit(UnRegisteredUser(
            email: userModel.email!,
            id: userModel.id!,
            isEmailVerified: userModel.isEmailVerified!));
      }
    } else if (tokenData && !userModel.isEmailVerified!) {
      emit(LoginEmailNotVerified(
          email: userModel.email!,
          id: userModel.id!,
          isEmailVerified: userModel.isEmailVerified!));
    } else if (profileData['errors']["details"] != null) {
      emit(LoginTokenError());
    } else if (!tokenData) {
      emit(LoginUnAuthenticated());
    }
  }
}
