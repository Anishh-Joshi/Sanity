
import 'package:flutter/material.dart';
import 'package:sanity/landingpage.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/introduction/app_information.dart.dart';
import 'package:sanity/screens/login/email_verification.dart';
import 'package:sanity/screens/login/forgot_password.dart';
import 'package:sanity/screens/login/login.dart';
import 'package:sanity/screens/login/login_landing.dart';
import 'package:sanity/screens/login/sign_up.dart';
import 'package:sanity/screens/login/user_info.dart';
import 'package:sanity/screens/message/messagePage.dart';
import 'package:sanity/screens/notifications/notification.dart';
import 'package:sanity/screens/profile/profile.dart';
import 'package:sanity/screens/therapy/therapy.dart';
import 'package:sanity/screens/write/write.dart';
import 'package:sanity/screens/write/write_textfield.dart';
import '../screens/doctor/doctor.dart';

class AppRouter {
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
      case WriteField.routeName:
        return WriteField.route();
      case EmailVerification.routeName:
        return EmailVerification.route();
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      case UserInfo.routeName:
        return UserInfo.route();
      case LandingPage.routeName:
        return LandingPage.route();
      case Home.routeName:
        return Home.route();
      case NotificationPage.routeName:
        return NotificationPage.route();
      case WritePage.routeName:
        return WritePage.route();
      case AppointmentInformation.routeName:
        return AppointmentInformation.route();
      case DoctorsPage.routeName:
        return DoctorsPage.route();
      case MessagePage.routeName:
        return MessagePage.route();
      case ProfilePage.routeName:
        return  ProfilePage.route();
      case Therapy.routeName:
        return Therapy.route(setting);
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
