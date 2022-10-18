import 'package:flutter/material.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/search_bar.dart';
import 'package:sanity/widgets/therapy_builder.dart';

class SeeAllTherapy extends StatelessWidget {
  static const String routeName = 'see_therapy';
    const SeeAllTherapy({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => SeeAllTherapy(), settings: setting);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
               physics:const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppBarInfo(height: height, onPressed: (){}, showDone: false, title: "All Therapies"),
                const SearchTherapy(),
                const TherapyBuilder(allView: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
