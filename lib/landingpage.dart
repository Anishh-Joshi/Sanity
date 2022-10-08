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
            const Center(child: CircularProgressIndicatorCustom());
          }
          else if (state is LoginUnAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'login_landing', (route) => false);
          }
         else if (state is InformationNotSeen) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'loginInfo', (route) => false);
          }
          else if (state is LoginEmailNotVerified) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'email_verification', (route) => false);
          }
          else if (state is UnRegisteredUser) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'user_info', (route) => false);
          }
          else if (state is LoginTokenError) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'token_err', (route) => false);
          }
          else if (state is AppInformationSkipedPressed) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'login_landing', (route) => false);
          }
          else if (state is LoginAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context,'home_landing', (route) => false,arguments: state.user);
          }
          else if (state is BackToLoginPage) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'login_landing', (route) => false);
          }
          
        },
        child: Scaffold(
          body: Column(
            children: [
              Image.asset(
                'assets/logos/sanity_half.png',
                height: 500,
              ),
              const CircularProgressIndicatorCustom(),
            ],
          ),
        ));
  }
}
