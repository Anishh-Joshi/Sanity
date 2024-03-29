part of 'user_info_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object?> get props => [];
}

class SignUpLoading extends UserInfoEvent {}

class UpdateUserInfo extends UserInfoEvent {
  final String? fullName;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final int? nmcId;
  final File? profileImage;
  final String? bio;

  const UpdateUserInfo(
      {this.fullName,
      this.address,
      this.bio,
      this.age,
      this.gender,
      this.isDoctor,
      this.nmcId,
      this.profileImage});

  @override
  List<Object?> get props =>
      [fullName, address, gender,bio, age, isDoctor, profileImage];
}

class SignUpPressed extends UserInfoEvent {
  final UserInfoModel userInfo;
  final int id;

  const SignUpPressed({required this.userInfo, required this.id});

  @override
  List<Object?> get props => [userInfo];
}


class ClearUserInfo extends UserInfoEvent {
}
