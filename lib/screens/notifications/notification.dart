import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/notification_bloc/notification_bloc.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import '../../widgets/bottom_appbar.dart';
import '../../widgets/custom_appbar.dart';
import 'package:basics/basics.dart';

extension DateTimeExt on DateTime {
  int get daysSince => this.difference(DateTime.now()).inDays;
}

class NotificationPage extends StatelessWidget {
  static const String routeName = 'notification';
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const NotificationPage(),
        settings: const RouteSettings(name: routeName));
  }

  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: MyCustomAppBar(
            elevation: 0,
            fontSize: 25,
            appBarTitle: '  Notifications',
            onPressed: () {}),
        bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginAuthenticated) {
              return CustomNavbar(isDoctor: state.user.isDoctor!);
            }
            return const SizedBox();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginAuthenticated) {
                context.read<NotificationBloc>().add(FetchNotifications(
                    cat: state.user.isDoctor! ? 'doc' : 'ran',
                    userId: state.user.userId!));
                return BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, st) {
                    if (st is NotificationLoaded) {
                      return ListView.builder(
                          itemCount: st.notification.length,
                          itemBuilder: (context, index) {
                            AppointmentModel notification =
                                AppointmentModel.fromJSON(st.notification[index]);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Theme.of(context).cardColor
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Appointment in ${(notification.atTime! - DateTime.now()).inDays} days",
                                      style: Theme.of(context).textTheme.headline5,
                                  )
                                  ),
                                ),
                               const SizedBox(height: 2,),
                                AppointmentCard(
                                    notificationView: true,
                                    height: height,
                                    appointmentMOdel: notification),
                              ],
                            );
                          });
                    }
                    return const SizedBox();
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
