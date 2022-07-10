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
  final bool? personalHelper;
  final int? nmcId;

  const UpdateUserInfo(
      {this.fullName,
      this.address,
      this.age,
      this.gender,
      this.isDoctor,
      this.nmcId,
      this.personalHelper});

  @override
  List<Object?> get props =>
      [fullName, address, gender, age, isDoctor, personalHelper];
}

class SignUpPressed extends UserInfoEvent {}
