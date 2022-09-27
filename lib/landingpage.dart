import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/widgets/circular_progress.dart';

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
            Navigator.pushNamedAndRemoveUntil(
                context, 'login_landing', (route) => false);
          }
          if (state is InformationNotSeen) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'loginInfo', (route) => false);
          }
          if (state is LoginEmailNotVerified) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'email_verification', (route) => false);
          }
          if (state is UnRegisteredUser) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'user_info', (route) => false);
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
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          }
        },
        child:  Scaffold(
          body: Column(
            children: [
              Image.asset('assets/logos/sanity_half.png',height: 500,),
              const CircularProgressIndicatorCustom(),
            ],
          ),
        ));
  }
}
