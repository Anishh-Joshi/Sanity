import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoModel extends Equatable {
  final String? fullName;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final int? nmcId;
  final XFile? profileImage;

  const UserInfoModel(
      {this.fullName,
      this.address,
      this.nmcId,
      this.age,
      this.gender,
      this.isDoctor,
      this.profileImage});

  String get getName {
    return fullName!;
  }

  int get getAge {
    return age!;
  }

  String get getAddress {
    return address!;
  }

  String get getGender {
    return gender!;
  }

  bool get getIsDoctor {
    return isDoctor!;
  }

  int get getNmcId {
    return nmcId!;
  }

  @override
  List<Object?> get props => [fullName, age, address, isDoctor, nmcId, gender];
}
