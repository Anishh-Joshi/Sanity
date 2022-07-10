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
      final authData = await repo.login(event.email, event.password);
      emit(LoginLoading());
      if (authData["token"] != null) {
        emit(LoginAuthenticated());
        repo.persistToken((authData["token"]['refresh']));
      } else {
        emit(LoginError(msg: authData['errors']['non_field_errors']));
      }
    } catch (e) {
      emit(LoginError(msg: e.toString()));
    }
  }
}
