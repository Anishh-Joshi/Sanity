import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/model/therapy_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TherapyCard extends StatelessWidget {
  final TherapyModel therapy;
  const TherapyCard(
      {Key? key,
      required this.therapy,
      })
      : super(key: key);

String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toBeginningOfSentenceCase(therapy.title!)! ,
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                children: [
                  Text(
                    "Dr. ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    therapy.doctorId.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(AntDesign.clockcircleo,size: 14,color: Theme.of(context).canvasColor,),
                  SizedBox(width: 4,),
                  Text(timeago.format(therapy.createdAt!),style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).canvasColor)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            therapy.category!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      Text(
                        " ${utf8convert(therapy.emoji!)}",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.pink, fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${therapy.involved}+",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.pink),
                      ),
                      Text(
                        " involved",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
