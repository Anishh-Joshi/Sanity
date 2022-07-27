import 'package:flutter/material.dart';
import 'package:sanity/landingpage.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/screens/introduction/app_information.dart.dart';
import 'package:sanity/screens/login/email_verification.dart';
import 'package:sanity/screens/login/forgot_password.dart';
import 'package:sanity/screens/login/login.dart';
import 'package:sanity/screens/login/login_landing.dart';
import 'package:sanity/screens/login/sign_up.dart';
import 'package:sanity/screens/login/user_info.dart';
import 'package:sanity/screens/profile/profile.dart';

class AppRouter {
  final AuthRepository repo;

  AppRouter(this.repo);
  static Route? onGenerateRoute(RouteSettings setting) {
    print("Route chosen ${setting.name}");

    switch (setting.name) {
      case LoginInformation.routeName:
        return LoginInformation.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case LoginLanding.routeName:
        return LoginLanding.route();
      case Signup.routeName:
        return Signup.route();
      case EmailVerification.routeName:
        return EmailVerification.route();
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      case UserInfo.routeName:
        return UserInfo.route();
      case LandingPage.routeName:
        return LandingPage.route();
      case ProfilePage.routeName:
        return ProfilePage.route();

      default:
        _errorRoute();
    }
    return null;
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
                appBar: AppBar(
              title: const Text("Error"),
            )),
        settings: const RouteSettings(name: '/error'));
  }
}
