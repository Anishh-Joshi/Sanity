import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/doctor/doctor.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/notifications/notification.dart';
import 'package:sanity/screens/write/write.dart';

class HomeLandingPage extends StatefulWidget {
  static const String routeName = 'home_landing';
  const HomeLandingPage({Key? key}) : super(key: key);
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => const HomeLandingPage(), settings: settings);
  }

  @override
  State<HomeLandingPage> createState() => _HomeLandingPageState();
}

class _HomeLandingPageState extends State<HomeLandingPage> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final UserInfoModel user =
        ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const Home(),
          const NotificationPage(),
          WritePage(),
          user.isDoctor! ? const AppointmentInformation() : const DoctorsPage()
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          const BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          const BottomBarItem(
            icon: Icon(MaterialIcons.notifications),
            title: Text('Notification'),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: Icon(MaterialCommunityIcons.plus_circle),
            title: Text('Add Log'),
            activeColor: Colors.greenAccent.shade700,
          ),
          user.isDoctor!
              ? const BottomBarItem(
                  icon: Icon(MaterialIcons.perm_contact_calendar),
                  title: Text('Appointments'),
                  activeColor: Colors.orange,
                )
              : const BottomBarItem(
                  icon: Icon(Fontisto.doctor),
                  title: Text('Doctors'),
                  activeColor: Colors.orange,
                ),
        ],
      ),
    );
  }
}
