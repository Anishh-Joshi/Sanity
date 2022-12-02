import 'package:dio/dio.dart';
import 'package:sanity/apis/apis.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/signup/abstract.dart';

class SignUpRepository extends BaseSignupRepository {
  final APIs api = APIs();
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
      Response response = await Dio()
          .post(api.setProfile, data: formData, options: Options(headers: {}));
      return response.statusCode!;
    } on DioError catch (e) {
      return e.response!.statusCode!;
    }
  }

  Future<int> updateUserInfo(UserInfoModel checkout,
      {required int id, required int profileId}) async {
    try {
      FormData formData = FormData.fromMap({
        'gender': checkout.gender,
        'isDoctor': checkout.isDoctor,
        'nmcId': checkout.nmcId,
        'bio': checkout.bio,
        "profileImage": checkout.profileImage == null
            ? null
            : await MultipartFile.fromFile(
                checkout.profileImage!.path,
              ),
        'location': checkout.address,
        'age': checkout.age,
        'full_name': checkout.fullName
      });
      Response response = await Dio().put(api.updateProfile(id: profileId),
          data: formData, options: Options(headers: {}));
      return response.statusCode!;
    } on DioError catch (e) {
      return e.response!.statusCode!;
    }
  }
}
