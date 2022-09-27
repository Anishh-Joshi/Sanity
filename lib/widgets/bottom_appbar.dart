import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/doctor/doctor.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/message/messagePage.dart';
import 'package:sanity/screens/notifications/notification.dart';
import 'package:sanity/screens/write/write.dart';

class CustomNavbar extends StatelessWidget {
  final bool isDoctor;
  const CustomNavbar({Key? key, required this.isDoctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Home.routeName);
            },
            icon: const Icon(Icons.home)),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationPage.routeName);
            },
            icon: const Icon(MaterialIcons.notifications)),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, WritePage.routeName);
          },
          icon: const Icon(MaterialCommunityIcons.plus_circle),
          iconSize: 40,
        ),
        isDoctor
            ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppointmentInformation.routeName);
                },
                icon: const Icon(MaterialIcons.perm_contact_calendar))
            : IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, DoctorsPage.routeName);
                },
                icon: const Icon(Fontisto.doctor)),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MessagePage.routeName);
            },
            icon: const Icon(MaterialCommunityIcons.message))
      ]),
    );
  }
}
