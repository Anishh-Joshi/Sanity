import 'package:flutter/material.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/therapy_builder.dart';
import 'package:sanity/widgets/thread_builder.dart';

class SeeAllThreads extends StatelessWidget {
  static const String routeName = 'see_threads';
    const SeeAllThreads({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => SeeAllThreads(), settings: setting);
  }

  @override
  Widget build(BuildContext context) {
      final double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              AppBarInfo(height: height, onPressed: (){}, showDone: false, title: 'All Threads'),
              const ThreadBuilder(allView: true,),
            ],
          ),
        ),
      ),
    );
  }
}
