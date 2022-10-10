import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/signup/signup_repo.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final SignUpRepository _signUpRepo;
  StreamSubscription? _signupSubscription;
  UserInfoBloc({required SignUpRepository signUpRepo})
      : _signUpRepo = signUpRepo,
        super(UserInfoLoading()) {
    on<UpdateUserInfo>(_onUpdateUserinfo);
    on<SignUpLoading>(_onSignUpLoading);
    on<SignUpPressed>(_onSignUpButtonPressed);
    on<ClearUserInfo>(_clearUserInfo);
  }

  void _onSignUpLoading(
    SignUpLoading event,
    Emitter<UserInfoState> emit,
  ) {
     print("got userInfo");
    emit(UserInfoLoaded());
  }

   void _clearUserInfo(
    ClearUserInfo event,
    Emitter<UserInfoState> emit,
  ) {
    print("Trigged");
    emit(UserInfoLoaded());
  }

  void _onUpdateUserinfo(
    UpdateUserInfo event,
    Emitter<UserInfoState> emit,
  ) {
    print("got userInfo");
    if (state is UserInfoLoaded) {
      final state = this.state as UserInfoLoaded;
      emit(UserInfoLoaded(
          fullName: event.fullName ?? state.fullName,
          address: event.address ?? state.address,
          age: event.age ?? state.age,
          isDoctor: event.isDoctor ?? state.isDoctor,
          gender: event.gender ?? state.gender,
          profileImage: event.profileImage ?? state.profileImage,
          nmcId: event.nmcId ?? state.nmcId));
    }
  }

  void _onSignUpButtonPressed(
    SignUpPressed event,
    Emitter<UserInfoState> emit,
  ) async {
    _signupSubscription?.cancel();
    emit(UserInfoLoading());
    try {
      final int resp =
          await _signUpRepo.addUserInfo(event.userInfo, id: event.id);
      if (resp == 201) {
        emit(SignupFormFilled());
      } else if (resp == 404) {
        emit(const UserInfoError(
            msg: "Something Went Wrong! Please Try Again."));
      }
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _signupSubscription?.cancel();
    return super.close();
  }
}
