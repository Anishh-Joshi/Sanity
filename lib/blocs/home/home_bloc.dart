import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginBloc _loginBloc;
  StreamSubscription? _loginblocSubscription;
  UserInfoModel? user;

  HomeBloc({required LoginBloc loginBloc})
      : _loginBloc = loginBloc,
        super(loginBloc.state is LoginAuthenticated
            ? HomeLoaded(user: (loginBloc.state as LoginAuthenticated).user)
            : HomeInitial()) {
    _loginblocSubscription = _loginBloc.stream.listen((state) {
      if (state is LoginAuthenticated) {
        add(UpdateHomeInfo(user: state.user));
      }
    });

    on<UpdateHomeInfo>(_updateHomeInfo);
  }

  void _updateHomeInfo(UpdateHomeInfo event, Emitter emit) {
    _loginblocSubscription?.cancel();
    emit(UpdateHomeInfo(user: user));
  }

  @override
  Future<void> close() {
    _loginblocSubscription?.cancel();
    return super.close();
  }
}
