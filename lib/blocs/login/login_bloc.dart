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
  }

  void _onLoginCheck(LoginCheck event, Emitter<LoginState> emit) async {
    bool tokenData = await repo.hasToken();
    if (tokenData) {
      emit(LoginAuthenticated());
    } else {
      emit(LoginUnAuthenticated());
    }
  }

  void _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final authData = await repo.login(event.email, event.password);
      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['refresh']));
        emit(LoginAuthenticated());
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
      final authData = await repo.login(event.email, event.password);
      if (authData["token"] != null) {
        repo.persistToken((authData["token"]['refresh']));
        emit(LoginAuthenticated());
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
}
