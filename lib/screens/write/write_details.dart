import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/widgets/filead_header.dart';

class WriteDetails extends StatelessWidget {
  static const String routeName = 'log_details';
  const WriteDetails({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const WriteDetails(), settings: setting);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final LogModel log = ModalRoute.of(context)!.settings.arguments as LogModel;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
             physics:const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppBarInfo(
                    margin: 0,
                    height: height,
                    onPressed: () {},
                    showDone: false,
                    title: ''),
                Text(
                  DateFormat.yMMMMd().format(DateTime.parse(log.createdAt)),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: height * 0.045),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Text(
                  log.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: height * 0.02),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
