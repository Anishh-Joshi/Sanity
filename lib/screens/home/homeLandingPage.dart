import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/doctor/doctor.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/message/messagePage.dart';
import 'package:sanity/screens/notifications/notification.dart';
import 'package:sanity/screens/write/write.dart';

class HomeLandingPage extends StatefulWidget {
  final UserInfoModel user;
  const HomeLandingPage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeLandingPage> createState() => _HomeLandingPageState();
}

class _HomeLandingPageState extends State<HomeLandingPage> {
  PersistentTabController? controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return  [
      const Home(),
      const NotificationPage(),
      const WritePage(),
      widget.user.isDoctor!? AppointmentInformation(user: widget.user,): const DoctorsPage(),
      const MessagePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MaterialIcons.notifications),
        title: ("Notification"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MaterialCommunityIcons.pentagon),
        title: ("Sanity"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
     widget.user.isDoctor!?PersistentBottomNavBarItem(
        icon: const Icon(MaterialIcons.perm_contact_calendar),
        title: ("Appointment"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ): PersistentBottomNavBarItem(
        icon: const Icon(Fontisto.doctor),
        title: ("Doctors"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(MaterialCommunityIcons.message),
        title: ("Messages"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          Theme.of(context).bottomAppBarColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
