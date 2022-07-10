import 'package:equatable/equatable.dart';

class UserInfoModel {
  final String? fullName;
  final String? address;
  final int? age;
  final String? gender;
  final bool? isDoctor;
  final int? nmcId;
  final bool? personalHelper;

  const UserInfoModel(
      {this.fullName,
      this.address,
      this.nmcId,
      this.age,
      this.gender,
      this.isDoctor,
      this.personalHelper});

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

  bool get getPersonalHelper {
    return personalHelper!;
  }
}
