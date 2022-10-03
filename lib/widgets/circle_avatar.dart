import 'package:flutter/material.dart';
import 'package:sanity/apis/apis.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          
          backgroundColor: Theme.of(context).cardColor,
            radius: radius,
            child: Image.asset('assets/images/default.png'),
          )
        : CircleAvatar(
          backgroundColor: Theme.of(context).cardColor,
            radius: radius,
            backgroundImage: CachedNetworkImageProvider("http://${api.localhost}$url",),
          );
  }
}
