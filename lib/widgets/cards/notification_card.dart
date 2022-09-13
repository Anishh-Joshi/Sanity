import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanity/widgets/arrow_forward_icon.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:math';

class NotificationCard extends StatelessWidget {
  final String heading;
  final String text;
  final DateTime createdAt;
  final double depression_score;
  NotificationCard(
      {Key? key,
      required this.depression_score,
      required this.heading,
      required this.text,
      required this.createdAt})
      : super(key: key);

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  List<Color> colorList = [
    Colors.red,
    Colors.pink,
    Colors.deepOrange,
    Colors.teal,
    Colors.green,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: height * 0.1,
            width: width * 0.25,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor,
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(14),
                color: colorList[random(0, 6)]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    heading.split(" ")[1].split(",")[0],
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    heading.split(" ")[0],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left:8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      text.length > 15
                          ? text.substring(0, 15).toUpperCase() + "..."
                          : text.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 16)),
                  Text(DateFormat.jm().format(createdAt),
                      style: Theme.of(context).textTheme.headline6)
                ],
              ),
            ),
          ),
          Container(
            height: height * 0.06,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SettingsIcon(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                callback: () {}),
          )
        ]),
      ),
    );
  }
}
