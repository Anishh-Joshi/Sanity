import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../model/therapy_model.dart';

class Therapy extends StatelessWidget {
  static const String routeName = 'therapy_info';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const Therapy(), settings: settings);
  }

  const Therapy({Key? key}) : super(key: key);
  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    var therapy = ModalRoute.of(context)!.settings.arguments as TherapyModel;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Text(
              therapy.title!,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: height * 0.03),
            ),
            SizedBox(
              height: height * 0.006,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By ${therapy.doctorId.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: height * 0.02),
                    ),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Text(
                      "Category "+therapy.category! + " " + utf8convert(therapy.emoji!),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: height * 0.02),
                    ),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Row(
                      children: [
                        Icon(
                          Fontisto.music_note,
                          size: height * 0.013,
                        ),
                        SizedBox(
                          width: height * 0.013,
                        ),
                        Text(
                          "Chill music",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.grey, fontSize: height * 0.018),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.006,
                    ),
                    Row(
                      children: [
                        Icon(
                          Fontisto.clock,
                          size: height * 0.013,
                        ),
                        SizedBox(
                          width: height * 0.013,
                        ),
                        Text(
                          timeago.format(therapy.createdAt!),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.grey, fontSize: height * 0.013),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${therapy.involved}+ involved",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white, fontSize: height * 0.015),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.transparent,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Expanded(
                child: Lottie.asset('assets/lottie/therapy.json',
                    height: height * 0.3)),
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.5,
                  child: ElevatedButtonCustom(
                      size: 16,
                      action: () {},
                      color: Colors.pink,
                      buttonTitle: "Start Now"),
                )),
          ]),
        ),
      ),
    );
  }
}
