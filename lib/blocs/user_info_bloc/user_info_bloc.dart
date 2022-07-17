import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
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
    print(event);
    if (state is UserInfoLoaded) {
      try {
        await _signUpRepo.addUserInfo(event.userInfo);
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _signupSubscription?.cancel();
    return super.close();
  }
}
