import 'package:flutter/material.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/screens/introduction/app_information.dart.dart';
import 'package:sanity/screens/login/login.dart';
import 'package:sanity/screens/login/login_landing.dart';

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

      default:
        _errorRoute();
    }
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
