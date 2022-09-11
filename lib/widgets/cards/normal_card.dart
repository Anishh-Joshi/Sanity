

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NormalCard extends StatelessWidget {
  final String heading;
  final String text;
  final double width;

  const NormalCard({super.key,required this.width, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: MediaQuery.of(context).size.height/7,
      width:width*0.9,
      decoration: BoxDecoration(
        color:  Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(heading,style: Theme.of(context).textTheme.headline4!.copyWith(fontSize:18)),
          Text( text,style: Theme.of(context).textTheme.headline5!.copyWith(fontSize:14)),

        ],),
      ),
    );
    
  }
}