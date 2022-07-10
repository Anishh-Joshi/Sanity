import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/user_info_model.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoModel info;
  UserInfoBloc({required this.info}) : super(UserInfoLoading()) {
    on<UpdateUserInfo>(_onUpdateUserinfo);
    on<SignUpLoading>(_onSignUpLoading);
    on<SignUpPressed>(_onSignUpButtonPressed);
  }

  void _onSignUpLoading(
    SignUpLoading event,
    Emitter<UserInfoState> emit,
  ) {
    emit(UserInfoLoaded());
  }

  void _onUpdateUserinfo(
    UpdateUserInfo event,
    Emitter<UserInfoState> emit,
  ) {
    emit(UserInfoLoaded());

    if (state is UserInfoLoaded) {
      info = UserInfoModel(
          fullName: event.fullName,
          address: event.address,
          age: event.age,
          isDoctor: event.isDoctor,
          personalHelper: event.personalHelper,
          gender: event.gender,
          nmcId: event.nmcId);
    }
  }

  void _onSignUpButtonPressed(
    SignUpPressed event,
    Emitter<UserInfoState> emit,
  ) {
    print("BUTTON PRESSED");
    print("NAME ISSSS ${info.getAge}");
  }
}
