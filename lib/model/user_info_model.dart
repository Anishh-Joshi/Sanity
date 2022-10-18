import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/user_class.dart';

class UserInfoModel extends Equatable {
  final String? fullName;
  final int? userId;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final int? nmcId;
  final String? bio;
  final DateTime? createdAt;
  final File? profileImage;
  final String? profileImgUrl;

  const UserInfoModel(
      {this.fullName,
      this.userId,
      this.bio,
      this.createdAt,
      this.address,
      this.profileImgUrl,
      this.nmcId,
      this.age,
      this.gender,
      this.isDoctor = false,
      this.profileImage});

  factory UserInfoModel.fromJson(Map response) {
    return UserInfoModel(
        bio: response['bio'],
        fullName: response['full_name'],
        address: response['location'],
        age: response['age'],
        createdAt: DateTime.parse(response['created_at']),
        gender: response['gender'],
        isDoctor: response['isDoctor'],
        nmcId: response['nmcId'],
        profileImgUrl: response['profileImage'],
        userId: response['id']);
  }

  @override
  List<Object?> get props =>
      [fullName, age, address, isDoctor, nmcId, gender, userId];
}
