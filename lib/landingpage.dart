import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/home/homeLandingPage.dart';
import 'package:sanity/screens/write/write_textfield.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = 'landing_page';
  const LandingPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void checkInformationScreen() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            const Center(child: CircularProgressIndicator());
          }
          if (state is LoginUnAuthenticated) {
            Navigator.pushNamed(
              context,
              'login_landing',
            );
          }
          if (state is InformationNotSeen) {
            Navigator.pushNamed(
              context,
              'loginInfo',
            );
          }
          if (state is LoginEmailNotVerified) {
            Navigator.pushNamed(
              context,
              'email_verification',
            );
          }
          if (state is UnRegisteredUser) {
            Navigator.pushNamed(
              context,
              'user_info',
            );
          }
          if (state is LoginTokenError) {
            Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("TOKEN EXPIRED or your Account is deleted"),
                  TextButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(BackToLoginPage());
                      },
                      child: const Text("Get back to Login Page"))
                ],
              ),
            );
          }
          if (state is LoginAuthenticated) {
            Navigator.pushNamed(context, Home.routeName);
          } else {
            const Center(child: Text("SOMETHING WENT WRONG"));
          }
        },
        child: const Center(child: CircularProgressIndicator()));
  }
}
