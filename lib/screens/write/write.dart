import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/screens/write/write_details.dart';
import 'package:sanity/screens/write/write_textfield.dart';
import 'package:sanity/widgets/cards/notification_card.dart';
import 'package:sanity/widgets/custom_appbar.dart';
import '../../blocs/login/login_bloc.dart';
import '../../widgets/bottom_appbar.dart';

class WritePage extends StatelessWidget {
  static const String routeName = 'logs';
  WritePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => WritePage(),
        settings: const RouteSettings(name: routeName));
  }

  int? userID;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
      bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginAuthenticated) {
            userID = state.user.userId;
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
      body: BlocListener<LogBlocBloc, LogBlocState>(
        listener: (context, state) {
          if (state is LogSent) {
            context.read<LogBlocBloc>().add(RetrieveLog(id: userID!));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, st) {
              if (st is HomeLoaded) {
                context
                    .read<LogBlocBloc>()
                    .add(RetrieveLog(id: st.user!.userId!));
                return BlocBuilder<LogBlocBloc, LogBlocState>(
                    builder: (context, state) {
                  if (state is LogRetrieved) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: false,
                      shrinkWrap: true,
                      itemCount: state.log.length,
                      itemBuilder: (context, index) {
                        state.log.sort((b, a) =>
                            a["created_at"].compareTo(b["created_at"]));
                        LogModel log = LogModel.fromJson(state.log[index]);

                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, WriteDetails.routeName,
                                    arguments: log)
                                .then((value) {
                              context
                                  .read<LogBlocBloc>()
                                  .add(RetrieveLog(id: st.user!.userId!));
                            });
                          },
                          child: NotificationCard(
                            heading: DateFormat.yMMMMd()
                                .format(DateTime.parse(log.createdAt)),
                            createdAt: DateTime.parse(log.createdAt),
                            text: log.text,
                            depression_score: log.depressionScore,
                          ),
                        );
                      },
                    );
                  } else if (state is LogBlocLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const Center(
                    child: Text(" Bloc Log Error"),
                  );
                });
              }
              return const CircularProgressIndicator(
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}
