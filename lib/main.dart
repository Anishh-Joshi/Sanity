import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/config/app_router.dart';
import 'package:sanity/config/theme.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'screens/introduction/app_information.dart.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repo = AuthRepository();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(repo: repo)..add(LoginCheck()))
      ],
      child: MaterialApp(
        title: 'Sanity',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: LoginInformation.routeName,
      ),
    );
  }
}
