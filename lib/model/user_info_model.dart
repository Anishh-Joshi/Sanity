import 'dart:io';
import 'package:equatable/equatable.dart';

class UserInfoModel extends Equatable {
  final String? fullName;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final int? nmcId;
  final File? profileImage;
  final String? profileImgUrl;

  const UserInfoModel(
      {this.fullName,
      this.address,
      this.profileImgUrl,
      this.nmcId,
      this.age,
      this.gender,
      this.isDoctor,
      this.profileImage});

  factory UserInfoModel.fromJson(Map response) {
    return UserInfoModel(
      fullName: response['full_name'],
      address: response['location'],
      age: response['age'],
      gender: response['gender'],
      isDoctor: response['isDoctor'],
      nmcId: response['nmcId'],
      profileImgUrl: response['profileImage'],
    );
  }

  @override
  List<Object?> get props => [fullName, age, address, isDoctor, nmcId, gender];
}
