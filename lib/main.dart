import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/config/app_router.dart';
import 'package:sanity/config/theme.dart';
import 'package:sanity/landingpage.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'model/user_info_model.dart';
import 'screens/introduction/app_information.dart.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repo = AuthRepository();
  final info = const UserInfoModel();
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(repo: repo)..add(LoginCheck())),
        BlocProvider(
          create: (context) => UserInfoBloc(info: info)..add(SignUpLoading()),
        ),
      ],
      child: MaterialApp(
        title: 'Sanity',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: LandingPage.routeName,
      ),
    );
  }
}
