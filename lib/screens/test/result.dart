import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
import 'package:sanity/widgets/filead_header.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBarInfo(
              height: height,
              onPressed: () {},
              showDone: false,
              title: "Your Result"),
          BlocBuilder<Dass41Bloc, Dass41State>(
            builder: (context, state) {
             if(state is Dass41Loaded){
               return Text("YOUR RESULT IS ${state.category}");
             }
             return const SizedBox();
            },
          )
        ],
      )),
    );
  }
}
