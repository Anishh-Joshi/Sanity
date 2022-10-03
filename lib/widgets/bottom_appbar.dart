import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/doctor/doctor.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/message/messagePage.dart';
import 'package:sanity/screens/notifications/notification.dart';
import 'package:sanity/screens/profile/profile.dart';
import 'package:sanity/screens/write/write.dart';
import 'package:sanity/widgets/circle_avatar.dart';

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
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if(state is HomeLoaded){
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(context, ProfilePage.routeName);
                },
                child: CircleAvatarCustom(radius: 18,url: state.user!.profileImgUrl!,));
            }
            return CircleAvatarCustom(radius: 18,url: '',);
          },
        )
      ]),
    );
  }
}
