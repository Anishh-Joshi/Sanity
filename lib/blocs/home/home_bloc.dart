import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/model/user_info_model.dart';

import '../../model/user_class.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginBloc _loginBloc;
  StreamSubscription? _loginblocSubscription;

  HomeBloc({required LoginBloc loginBloc})
      : _loginBloc = loginBloc,
        super(loginBloc.state is LoginAuthenticated
            ? HomeLoaded(
                baseUser: (loginBloc.state as LoginAuthenticated).userBase,
                user: (loginBloc.state as LoginAuthenticated).user)
            : HomeInitial()) {
    on<UpdateHomeInfo>(_updateHomeInfo);
  }

  void _updateHomeInfo(UpdateHomeInfo event, Emitter emit) async {
    final Map received = await _loginBloc.repo.getProfileData();
    User userBase = User.fromJson(received);
    final Map userData =
        await _loginBloc.repo.registeredProfileData(id:userBase.id!);
    UserInfoModel user = UserInfoModel.fromJson(userData['candidates']);
    emit(HomeLoaded(user: user, baseUser: userBase));
    _loginblocSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _loginblocSubscription?.cancel();
    return super.close();
  }
}
