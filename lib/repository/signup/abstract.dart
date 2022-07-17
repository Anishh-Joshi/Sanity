import 'package:sanity/model/user_info_model.dart';

abstract class BaseSignupRepository {
  Future<void> addUserInfo(UserInfoModel checkout);
}
