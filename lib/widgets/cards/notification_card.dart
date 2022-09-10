

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  final String heading;
  final String text;
  final DateTime createdAt;
  final double depression_score;
  const NotificationCard({Key? key, required this.depression_score, required this.heading, required this.text, required this.createdAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: MediaQuery.of(context).size.height/7,
      width:MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(
        color:  Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
        Icon(Icons.pentagon,color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.height/10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(heading,style: Theme.of(context).textTheme.headline4!.copyWith(fontSize:18)),
          Text(text.length > 25 ? text.substring(0, 25)+'...' : text,style: Theme.of(context).textTheme.headline5!.copyWith(fontSize:14)),
          Row(
            children:[
              Icon(Icons.watch_later_rounded,size: 14,),
              Text( timeago.format(createdAt),style: Theme.of(context).textTheme.bodyText1)

            ]
          )

        ],),
        

      ]),
    );
    
  }
}