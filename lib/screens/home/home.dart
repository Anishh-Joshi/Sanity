import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';

import '../../widgets/platform_aware.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          const PlatformAADialog(
            title: 'Oops',
            content: "Something Went Wrong!",
            defaultActionText: "Ok",
          ).show(context);
        } else if (state is LoginUnAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'landing_page', (route) => false);
        }
      },
      child: Column(children: [
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginAuthenticated) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LogoutButtonPressed());
                  },
                  child: const Text("LogOut"));
            }
            return const Text("THAHA CHAINA K HO YO ");
          },
        ),
        BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoaded) {
            return Text("mein Ninja Hattori${state.user!.fullName!}");
          }
          return Text("garo cha garoo");
        })
      ]),
    )));
  }
}
