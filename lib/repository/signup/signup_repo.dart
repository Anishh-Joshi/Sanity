

import 'package:dio/dio.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/signup/abstract.dart';

class SignUpRepository extends BaseSignupRepository {
  @override
  Future<int> addUserInfo(UserInfoModel checkout, {required int id}) async {
    try {
      FormData formData = FormData.fromMap({
        'user': id,
        'gender': checkout.gender,
        'isDoctor': checkout.isDoctor,
        'nmcId': checkout.nmcId,
        "profileImage": checkout.profileImage == null
            ? null
            : await MultipartFile.fromFile(
                checkout.profileImage!.path,
              ),
        'location': checkout.address,
        'age': checkout.age,
        'full_name': checkout.fullName
      });
      Response response = await Dio().post(
          'http://10.0.2.2:8000/api/user/setprofile/',
          data: formData,
          options: Options(headers: {}));
      return response.statusCode!;
    } on DioError catch (e) {
      return e.response!.statusCode!;
    }
  }
}
