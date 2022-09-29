import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login/login_bloc.dart';

class TokenError extends StatelessWidget {
  static const String routeName = 'token_err';
  const TokenError({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const TokenError(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Oops,",style: Theme.of(context).textTheme.headline4,),
             Text("TOKEN EXPIRED or your Account is deleted :( ",style: Theme.of(context).textTheme.headline4,),
            TextButton(
              
                onPressed: () {
                  context.read<LoginBloc>().add(BackToLoginPage());
                  Navigator.pushNamedAndRemoveUntil(
                              context, 'login_landing', (route) => false);
                },
                child:  Text("Get back to Login Page",style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.pink),))
          ],
        ),
      ),
    );
  }
}
