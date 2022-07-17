import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/signup/abstract.dart';

class SignUpRepository extends BaseSignupRepository {
  @override
  Future<void> addUserInfo(UserInfoModel checkout) async {
    print(checkout);
    print(checkout.fullName);
  }
}
