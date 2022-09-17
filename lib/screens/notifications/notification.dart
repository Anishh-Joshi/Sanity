import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';

import '../../widgets/bottom_appbar.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = 'notification';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const NotificationPage(),
        settings: const RouteSettings(name: routeName));
  }

  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginAuthenticated) {
              return CustomNavbar(isDoctor: state.user.isDoctor!);
            }
            return const SizedBox();
          },
        ),
        body: Center(child: const Text("THIs IS NOTIFICTION PAGE")));
  }
}
