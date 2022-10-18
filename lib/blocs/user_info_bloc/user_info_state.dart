part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object?> get props => [];
}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final String? fullName;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final String?bio;
  final int? nmcId;
  final File? profileImage;
  final UserInfoModel userInfoModel;

  UserInfoLoaded(
      {this.fullName,
      this.address,
      this.age,
      this.gender,
      this.isDoctor,
      this.bio,
      this.profileImage,
      this.nmcId})
      : userInfoModel = UserInfoModel(
            fullName: fullName,
            bio: bio,
            age: age,
            address: address,
            gender: gender,
            nmcId: nmcId,
            isDoctor: isDoctor,
            profileImage: profileImage);

  @override
  List<Object?> get props =>
      [fullName, address, gender, age,bio, isDoctor, profileImage, nmcId];
}

class SignupFormFilled extends UserInfoState {}

class UserInfoError extends UserInfoState {
  final String msg;

  const UserInfoError({required this.msg});
  @override
  List<Object> get props => [msg];
}
