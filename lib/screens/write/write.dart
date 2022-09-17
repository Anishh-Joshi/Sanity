import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/screens/write/write_textfield.dart';
import 'package:sanity/widgets/cards/notification_card.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_appbar.dart';

import '../../blocs/login/login_bloc.dart';
import '../../widgets/bottom_appbar.dart';

class WritePage extends StatelessWidget {
  static const String routeName = 'logs';
  const WritePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const WritePage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
      bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginAuthenticated) {
            return CustomNavbar(isDoctor: state.user.isDoctor!);
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, WriteField.routeName);
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.edit),
      ),
      appBar: MyCustomAppBar(
          elevation: 0,
          fontSize: 25,
          appBarTitle: '  Daily Logs',
          onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if(state is HomeLoaded){
              context.read<LogBlocBloc>().add(RetrieveLog(id: state.user!.userId!));
               return BlocBuilder<LogBlocBloc, LogBlocState>(
                builder: (context, state) {
              if (state is LogRetrieved) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: state.log.length,
                  itemBuilder: (context, index) {
                    state.log.sort(
                        (b, a) => a["created_at"].compareTo(b["created_at"]));
                    LogModel log = LogModel.fromJson(state.log[index]);

                    return NotificationCard(
                      heading: DateFormat.yMMMMd()
                          .format(DateTime.parse(log.createdAt)),
                      createdAt: DateTime.parse(log.createdAt),
                      text: log.text,
                      depression_score: log.depressionScore,
                    );
                  },
                );
              } else if (state is LogBlocLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
            }
            return const CircularProgressIndicatorCustom();
           
          },
        ),
      ),
    );
  }
}
