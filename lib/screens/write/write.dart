import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/screens/write/write_textfield.dart';
import 'package:sanity/widgets/cards/notification_card.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    context.read<LogBlocBloc>().add(RetrieveLog());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WriteField()));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit),
      ),
      appBar: MyCustomAppBar(
          elevation: 0,
          fontSize: 25,
          appBarTitle: '  Daily Logs',
          onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            BlocBuilder<LogBlocBloc, LogBlocState>(builder: (context, state) {
              //do something
          if (state is LogRetrieved) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: false,
              shrinkWrap: true,
              itemCount: state.log.length,
              itemBuilder: (context, index) {
                state.log.sort((b,a)=> a["created_at"].compareTo(b["created_at"]));
                LogModel log = LogModel.fromJson(state.log[index]);
                
                return NotificationCard(
                  heading:
                      DateFormat.yMMMMd().format(DateTime.parse(log.createdAt)),
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
        }),
      ),
    );
  }
}
