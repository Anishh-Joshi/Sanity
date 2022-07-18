import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/signup/abstract.dart';

class SignUpRepository extends BaseSignupRepository {
  @override
  Future<dynamic> addUserInfo(UserInfoModel checkout) async {
    try {
      FormData formData = FormData.fromMap({
        'user': 3,
        "dob": '2000-10-19',
        'gender': checkout.gender,
        'isDoctor': checkout.isDoctor,
        'nmcId': checkout.nmcId,
        "profileImage": await MultipartFile.fromFile(
          checkout.profileImage!.path,
        ),
        'location': checkout.address,
        'age': checkout.age
      });
      print("HEREwew");
      Response response = await Dio().post(
          'http://10.0.2.2:8000/api/user/setprofile/',
          data: formData,
          options: Options(headers: {}));

      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    } catch (e) {}
  }
}
