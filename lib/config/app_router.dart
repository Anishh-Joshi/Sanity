import 'package:flutter/material.dart';
import 'package:sanity/screens/login/app_information.dart.dart';
import 'package:sanity/screens/login/login.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings setting) {
    print("Route chosen ${setting.name}");

    switch (setting.name) {
      case LoginInformation.routeName:
        return LoginInformation.route();
      case LoginScreen.routeName:
        return LoginScreen.route();

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
