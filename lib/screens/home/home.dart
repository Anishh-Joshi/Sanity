import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';

import '../../widgets/platform_aware.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).indicatorColor),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "${greetingMessage()},",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.height / 25),
                  ),
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                    if (state is HomeLoaded) {
                      return Text("${state.user!.fullName}",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30));
                    }
                    return const Text("Something Went Wrong");
                  }),
                ]),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return state.user!.profileImgUrl == '/media/default.jpg'
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: MediaQuery.of(context).size.height / 18,
                              child: Image.asset('assets/images/default.png'),
                            )
                          : CircleAvatar(
                              radius: MediaQuery.of(context).size.height / 18,
                              backgroundImage: NetworkImage(
                                  "http://10.0.2.2:8000" +
                                      state.user!.profileImgUrl!),
                            );
                    }
                    return const CircleAvatar();
                  },
                )
              ],
            ),
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
          ]),
        ),
      )),
      drawer: Drawer(backgroundColor: Colors.black),
    );
  }
}
