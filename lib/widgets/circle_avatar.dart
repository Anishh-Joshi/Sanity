import 'package:flutter/material.dart';
import 'package:sanity/apis/apis.dart';

class CircleAvatarCustom extends StatelessWidget {
  final APIs api = APIs();
  final String url;
  final double radius;

   CircleAvatarCustom({Key? key, required this.url, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url == '/media/default.jpg'
        ? CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: radius,
            child: Image.asset('assets/images/default.png'),
          )
        : CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage("http://10.0.2.2:8000$url"),
          );
  }
}
