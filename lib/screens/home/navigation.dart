import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/report_bloc/report_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/screens/doctor/appointment_information.dart';
import 'package:sanity/screens/doctor/doctor.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/screens/medications/medications.dart';
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
  void onPageChanged(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
  }

  void onTap(int pageIndex) {
    setState(() {});
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final UserInfoModel user =
        ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage == 0) {
          return true;
        }
        onTap(0);
        setState(() {});
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: [
            const Home(),
            const NotificationPage(),
            WritePage(),
            user.isDoctor!
                ? const AppointmentInformation()
                : const DoctorsPage(),
            const Medications()
          ],
        ),
        bottomNavigationBar: BottomBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedIndex: _currentPage,
          onTap: (index) {
            if (index == 4) {
              context.read<ReportBloc>().add(FetchReports(user: user));
            }
            onTap(index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: const Icon(Icons.home),
              activeColor: Theme.of(context).primaryColor,
            ),
            BottomBarItem(
              icon: const Icon(MaterialIcons.notifications),
              activeColor: Theme.of(context).primaryColor,
            ),
            BottomBarItem(
              icon: const Icon(MaterialCommunityIcons.plus_circle),
              activeColor: Theme.of(context).primaryColor,
            ),
            user.isDoctor!
                ? BottomBarItem(
                    icon: const Icon(MaterialIcons.perm_contact_calendar),
                    activeColor: Theme.of(context).primaryColor,
                  )
                : BottomBarItem(
                    icon: const Icon(Fontisto.doctor),
                    activeColor: Theme.of(context).primaryColor,
                  ),
            BottomBarItem(
              icon: const Icon(MaterialCommunityIcons.pill),
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
