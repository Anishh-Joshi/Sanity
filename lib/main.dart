import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/appointment/appointment_bloc.dart';
import 'package:sanity/blocs/profile_bloc/profile_bloc.dart';
import 'package:sanity/blocs/report_bloc/report_bloc.dart';
import 'package:sanity/blocs/comment_bloc/comment_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/notification_bloc/notification_bloc.dart';
import 'package:sanity/blocs/search_bloc/search_bloc.dart';
import 'package:sanity/blocs/theme/theme_bloc_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/config/app_router.dart';
import 'package:sanity/config/theme.dart';
import 'package:sanity/landingpage.dart';
import 'package:sanity/repository/appointment_repository/appointment_repo.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/repository/das_repository/das_repo.dart';
import 'package:sanity/repository/doctor_repository/doc_repo.dart';
import 'package:sanity/repository/log_repository/log_repo.dart';
import 'package:sanity/repository/signup/signup_repo.dart';
import 'package:sanity/repository/therapy_repository/therapy_repo.dart';
import 'package:sanity/repository/threads_repository/threds_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sanity/screens/home/home.dart';
import 'blocs/dass_bloc/dass41_bloc.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                Dass41Bloc(repo: DasRepo())..add(const GetDas(check: false)),
          ),
          BlocProvider(
            create: (context) => ReportBloc(),
          ),
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(
              create: (context) => CommentBloc(threadRepo: ThreadsRepo())),
          BlocProvider(
              create: (context) =>
                  NotificationBloc(repo: AppointmentRepository())),
          BlocProvider(
              create: (context) => ThreadsBloc(threadRepo: ThreadsRepo())
                ..add(FetchAllThreads())),
          BlocProvider(
              create: (context) =>
                  AppointmentBloc(repo: AppointmentRepository())),
          BlocProvider(create: (context) => ThemeBloc()..add(LoadTheme())),
          BlocProvider(
              create: (context) => DoctorBloc(docRepo: DoctorRepository())),
          BlocProvider(create: (context) => LogBlocBloc(repo: LogRepository())),
          BlocProvider(
              create: (context) =>
                  TherapyBloc(repo: TherapyRepository())..add(GetAllTherapy())),
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
          BlocProvider(
            create: (context) =>
                ProfileBloc(homeBloc: context.read<HomeBloc>()),
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
