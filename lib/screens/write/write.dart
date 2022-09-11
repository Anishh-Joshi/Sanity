import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/widgets/cards/notification_card.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogBlocBloc>().add(RetrieveLog());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
            
              onPressed: () {
                Navigator.pushNamed(context,"write-log");
              },   
              child: const Icon(Icons.edit),
              backgroundColor: Theme.of(context).primaryColor,
            ),
      appBar: MyCustomAppBar(
          appBarTitle: 'Daily Logs', onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LogBlocBloc,LogBlocState>(
          builder: (context,state){
            if(state is LogRetrieved){
              
              return ListView.builder(
                reverse: true,
                itemCount: state.log.length,
                itemBuilder: (context,index){
                  LogModel log = LogModel.fromJson(state.log[index]);
                  return NotificationCard(heading: DateFormat.yMMMMd().format(DateTime.parse(log.createdAt)),createdAt: DateTime.parse(log.createdAt),text: log.text,depression_score: log.depressionScore,);

                },
                 );
            }
            else if(state is LogBlocLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return const Center(child: CircularProgressIndicator(),);
          }
          ),
      ),
    );
  }
}
