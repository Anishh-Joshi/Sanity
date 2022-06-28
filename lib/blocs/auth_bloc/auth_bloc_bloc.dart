import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocLoading()) {
    on<AuthStarted>(_onLoadingState);
    on<LoginPressed>(_onLoginPressed);
  }

  _onLoadingState(AuthStarted event, Emitter<AuthBlocState> emit) async* {
    emit(AuthBlocLoading());
  }

  _onLoginPressed(LoginPressed event, Emitter<AuthBlocState> emit) async* {
    var pref = await SharedPreferences.getInstance();
    try {
      emit(AuthLoading());
      var data = await Authrepository.login(event.email, event.pasword);
      pref.setString("refresh", data['token']);
      emit(AuthLoaded());
    } on Exception {
      emit(const LoginErrorState(message: "Something went Wrong"));
    }
  }
}
