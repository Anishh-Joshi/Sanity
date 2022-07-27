import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/theme/theme_bloc_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/config/app_router.dart';
import 'package:sanity/config/theme.dart';
import 'package:sanity/landingpage.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/repository/signup/signup_repo.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()..add(LoadTheme())),
          BlocProvider(
              create: (context) => LoginBloc(
                    repo: AuthRepository(),
                  )..add(LoginCheck())),
          BlocProvider(
            create: (context) => UserInfoBloc(signUpRepo: SignUpRepository())
              ..add(SignUpLoading()),
          ),
          BlocProvider(
            create: (context) => HomeBloc(loginBloc: context.read<LoginBloc>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeBlocState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Sanity',
              debugShowCheckedModeBanner: false,
              theme: theme(isDark: state.isDark),
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: LandingPage.routeName,
            );
          },
        ));
  }
}
